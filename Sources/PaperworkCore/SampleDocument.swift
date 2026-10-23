import AppKit
import PDFKit

public enum SampleDocument {
    public static func make() throws -> Workspace {
        let data = NSMutableData(); var box = CGRect(x: 0, y: 0, width: 595, height: 842)
        guard let consumer = CGDataConsumer(data: data), let context = CGContext(consumer: consumer, mediaBox: &box, nil) else { throw PaperworkError.invalid("The sample could not be created.") }
        for index in 1...3 {
            context.beginPDFPage(nil); context.setFillColor(NSColor.white.cgColor); context.fill(box)
            let ns = NSGraphicsContext(cgContext: context, flipped: false); NSGraphicsContext.saveGraphicsState(); NSGraphicsContext.current = ns
            let lines: [(String, CGFloat, CGFloat, NSFont.Weight)] = [
                ("SAMPLE / FIELD NOTES", 730, 11, .semibold),
                (index == 1 ? "A little less paperwork." : (index == 2 ? "Make your mark." : "Keep the original."), 666, 29, .semibold),
                ("A local document workspace", 628, 15, .regular),
                ("PROJECT  /  MEADOW HOUSE", 564, 11, .semibold),
                ("Page \(index) contains synthetic text for testing.", 530, 14, .regular),
                ("Select this sentence, then choose Highlight or Underline.", 496, 14, .regular),
                ("Add a note, draw a line, or organise the pages.", 462, 14, .regular),
                ("Your original stays unchanged when you save a copy.", 428, 14, .regular),
                ("Prepared locally. No account. No upload.", 354, 14, .regular),
                ("SAMPLE DOCUMENT    /    \(index) OF 3", 70, 11, .medium)
            ]
            for (text, y, size, weight) in lines { (text as NSString).draw(at: NSPoint(x: 54, y: y), withAttributes: [.font: NSFont.systemFont(ofSize: size, weight: weight), .foregroundColor: NSColor.black]) }
            NSGraphicsContext.restoreGraphicsState(); context.endPDFPage()
        }
        context.closePDF(); guard let pdf = PDFDocument(data: data as Data) else { throw PaperworkError.invalid("The sample could not be read.") }
        let field = PDFAnnotation(bounds: NSRect(x: 54, y: 252, width: 300, height: 30), forType: .widget, withProperties: nil)
        field.widgetFieldType = .text; field.fieldName = "Project contact"; field.widgetStringValue = "Sample person"; field.backgroundColor = .init(white: 0.95, alpha: 1); field.font = .systemFont(ofSize: 14); pdf.page(at: 0)?.addAnnotation(field)
        return Workspace(document: pdf)
    }
}
