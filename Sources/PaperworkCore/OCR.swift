import AppKit
import PDFKit
import Vision
import CoreText

public enum LocalOCR {
    /// Rasterises each page. Output is deliberately a separate flattened, searchable PDF.
    public static func searchableCopy(data: Data, cancelled: () -> Bool = { false }, progress: (Int, Int) -> Void = { _, _ in }) throws -> PDFDocument {
        guard let source = PDFDocument(data: data), source.pageCount > 0, source.pageCount <= 100, !source.isLocked, !source.isEncrypted, source.allowsCopying, !Workspace.containsSignature(source, data: data) else { throw PaperworkError.invalid("OCR supports 1 to 100 unrestricted, unsigned pages at a time. Extract a smaller section first.") }
        guard data.count <= Workspace.maxBytes else { throw PaperworkError.invalid("Extract a smaller section before OCR.") }
        var totalPixels: Double = 0
        for index in 0..<source.pageCount {
            guard let page = source.page(at: index) else { throw PaperworkError.invalid("A page could not be read.") }
            let bounds = page.bounds(for: .mediaBox)
            let pixels = bounds.width * bounds.height * 4
            guard bounds.width.isFinite, bounds.height.isFinite, bounds.width > 0, bounds.height > 0, bounds.width <= 2400, bounds.height <= 2400, pixels <= 12_000_000 else { throw PaperworkError.invalid("This page is too large for safe OCR. Extract a smaller page first.") }
            totalPixels += pixels
        }
        guard totalPixels <= 160_000_000 else { throw PaperworkError.invalid("This document is too large for one OCR task. Extract a smaller section first.") }
        let buffer = NSMutableData()
        guard let consumer = CGDataConsumer(data: buffer), let context = CGContext(consumer: consumer, mediaBox: nil, nil) else { throw PaperworkError.invalid("A searchable copy could not be started.") }
        for i in 0..<source.pageCount {
            if cancelled() { throw PaperworkError.invalid("OCR stopped. The working copy was kept.") }
            try autoreleasepool { () throws -> Void in
            guard let page = source.page(at: i) else { throw PaperworkError.invalid("A page could not be read.") }
            let bounds = page.bounds(for: .mediaBox)
            guard bounds.width > 0, bounds.height > 0, bounds.width <= 2400, bounds.height <= 2400 else { throw PaperworkError.invalid("This page is too large for safe OCR.") }
            // PDFPage.thumbnail accounts for rotation. Output normalises rotation into its media size.
            let rotated = page.rotation % 180 != 0
            let size = CGSize(width: rotated ? bounds.height : bounds.width, height: rotated ? bounds.width : bounds.height)
            let image = page.thumbnail(of: NSSize(width: size.width * 2, height: size.height * 2), for: .mediaBox)
            var rect = CGRect(origin: .zero, size: image.size)
            guard let cg = image.cgImage(forProposedRect: &rect, context: nil, hints: nil) else { throw PaperworkError.invalid("This page could not be rendered for OCR.") }
            let request = VNRecognizeTextRequest(); request.recognitionLevel = .accurate; request.recognitionLanguages = ["en-GB"]; request.usesLanguageCorrection = true
            try VNImageRequestHandler(cgImage: cg, options: [:]).perform([request])
            if cancelled() { throw PaperworkError.invalid("OCR stopped. The working copy was kept.") }
            context.beginPDFPage([kCGPDFContextMediaBox as String: NSData(bytes: [CGRect(origin: .zero, size: size)], length: MemoryLayout<CGRect>.size)] as CFDictionary)
            context.draw(cg, in: CGRect(origin: .zero, size: size))
            for observation in request.results ?? [] {
                guard let candidate = observation.topCandidates(1).first, !candidate.string.isEmpty else { continue }
                let box = observation.boundingBox
                let font = CTFontCreateWithName("Helvetica" as CFString, max(5, box.height * size.height), nil)
                let line = CTLineCreateWithAttributedString(NSAttributedString(string: candidate.string, attributes: [.font: font]))
                let width = CGFloat(CTLineGetTypographicBounds(line, nil, nil, nil))
                context.saveGState(); context.setTextDrawingMode(.invisible)
                context.translateBy(x: box.minX * size.width, y: box.minY * size.height)
                if width > 0 { context.scaleBy(x: box.width * size.width / width, y: 1) }
                context.textPosition = .zero; CTLineDraw(line, context); context.restoreGState()
            }
            context.endPDFPage()
            }
            guard buffer.length <= 128 * 1024 * 1024 else { throw PaperworkError.invalid("The OCR output is too large. Extract a smaller section and try again.") }
            progress(i + 1, source.pageCount)
        }
        context.closePDF()
        guard buffer.length <= 128 * 1024 * 1024 else { throw PaperworkError.invalid("The OCR output is too large. Extract a smaller section and try again.") }
        guard let out = PDFDocument(data: buffer as Data), out.pageCount == source.pageCount else { throw PaperworkError.invalid("The searchable copy could not be verified.") }; return out
    }
}

public final class CancellationFlag: @unchecked Sendable {
    private let lock = NSLock(); private var value = false
    public init() {}
    public func cancel() { lock.lock(); value = true; lock.unlock() }
    public var isCancelled: Bool { lock.lock(); defer { lock.unlock() }; return value }
}
