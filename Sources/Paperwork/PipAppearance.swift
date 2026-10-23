import AppKit
import QuartzCore

enum PaperworkEdition: String {
    case baseline
    case baselinePlus = "baseline-plus"
    case pip
    case pipPlus = "pip-plus"

    var usesPipTheme: Bool { self == .pip || self == .pipPlus }
    var hasPlusFeatures: Bool { self == .baselinePlus || self == .pipPlus }
    var displayName: String { usesPipTheme ? "Pip Paperwork" : "Paperwork Baseline" }
    var defaultDataDirectory: String {
        switch self {
        case .baseline: "PaperworkBaseline"
        case .baselinePlus: "PaperworkCorePlus"
        case .pip: "PipPaperwork"
        case .pipPlus: "PipCorePlus"
        }
    }

    static func resolve(bundle: Bundle = .main, arguments: [String] = CommandLine.arguments) -> PaperworkEdition {
        if arguments.contains("--baseline-plus") { return .baselinePlus }
        if arguments.contains("--pip-plus") { return .pipPlus }
        if arguments.contains("--baseline") { return .baseline }
        if arguments.contains("--pip") { return .pip }
        guard let raw = bundle.object(forInfoDictionaryKey: "PaperworkEdition") as? String else { return .baseline }
        return PaperworkEdition(rawValue: raw) ?? .baseline
    }

    static func dataDirectory(bundle: Bundle = .main, edition: PaperworkEdition, arguments: [String] = CommandLine.arguments) -> String {
        let hasEditionOverride = arguments.contains(where: { ["--baseline", "--baseline-plus", "--pip", "--pip-plus"].contains($0) })
        guard !hasEditionOverride else { return edition.defaultDataDirectory }
        guard let configured = bundle.object(forInfoDictionaryKey: "PaperworkDataDirectory") as? String,
              !configured.isEmpty,
              !configured.contains("/"),
              configured != ".",
              configured != ".." else { return edition.defaultDataDirectory }
        return configured
    }
}

enum PipTheme: String {
    case paper
    case oat
}

enum PaperworkColorMode: String {
    case system
    case light
    case dark
}

struct PipPalette {
    let canvas: NSColor
    let ink: NSColor
    let secondary: NSColor
    let accent: NSColor

    static func make(theme: PipTheme, dark: Bool) -> PipPalette {
        switch (theme, dark) {
        case (.paper, false):
            PipPalette(canvas: .hex(0xFFFFFF), ink: .hex(0x121211), secondary: .hex(0x555555), accent: .hex(0x121211))
        case (.paper, true):
            PipPalette(canvas: .hex(0x0F0F0E), ink: .hex(0xF1F1EE), secondary: .hex(0xA3A3A0), accent: .hex(0xF1F1EE))
        case (.oat, false):
            PipPalette(canvas: .hex(0xF6F2EA), ink: .hex(0x1E1B16), secondary: .hex(0x615B52), accent: .hex(0xB4532A))
        case (.oat, true):
            PipPalette(canvas: .hex(0x181512), ink: .hex(0xF2EDE3), secondary: .hex(0xB9B1A5), accent: .hex(0xE0865C))
        }
    }
}

private extension NSColor {
    static func hex(_ value: UInt32) -> NSColor {
        NSColor(calibratedRed: CGFloat((value >> 16) & 0xFF) / 255,
                green: CGFloat((value >> 8) & 0xFF) / 255,
                blue: CGFloat(value & 0xFF) / 255,
                alpha: 1)
    }
}

final class PipPebbleView: NSView {
    private let pausedKey = "io.github.ghostzy0.paperwork.pipPaused"
    var palette = PipPalette.make(theme: .paper, dark: false) { didSet { needsDisplay = true } }
    var isPaused: Bool {
        get { UserDefaults.standard.bool(forKey: pausedKey) }
        set { UserDefaults.standard.set(newValue, forKey: pausedKey); if newValue { layer?.removeAnimation(forKey: "successHop") } }
    }

    override var isFlipped: Bool { false }
    override var acceptsFirstResponder: Bool { false }
    override func isAccessibilityElement() -> Bool { false }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        let box = bounds.insetBy(dx: bounds.width * 0.1, dy: bounds.height * 0.08)
        let body = NSBezierPath()
        body.move(to: NSPoint(x: box.minX + box.width * 0.17, y: box.minY + box.height * 0.2))
        body.curve(to: NSPoint(x: box.minX + box.width * 0.22, y: box.maxY - box.height * 0.17), controlPoint1: NSPoint(x: box.minX - box.width * 0.01, y: box.minY + box.height * 0.48), controlPoint2: NSPoint(x: box.minX + box.width * 0.02, y: box.maxY - box.height * 0.03))
        body.curve(to: NSPoint(x: box.maxX - box.width * 0.12, y: box.maxY - box.height * 0.21), controlPoint1: NSPoint(x: box.minX + box.width * 0.42, y: box.maxY + box.height * 0.05), controlPoint2: NSPoint(x: box.maxX - box.width * 0.02, y: box.maxY + box.height * 0.03))
        body.curve(to: NSPoint(x: box.maxX - box.width * 0.15, y: box.minY + box.height * 0.17), controlPoint1: NSPoint(x: box.maxX + box.width * 0.05, y: box.maxY - box.height * 0.36), controlPoint2: NSPoint(x: box.maxX + box.width * 0.02, y: box.minY + box.height * 0.02))
        body.curve(to: NSPoint(x: box.minX + box.width * 0.17, y: box.minY + box.height * 0.2), controlPoint1: NSPoint(x: box.maxX - box.width * 0.47, y: box.minY - box.height * 0.02), controlPoint2: NSPoint(x: box.minX + box.width * 0.3, y: box.minY + box.height * 0.02))
        body.close()
        palette.ink.setFill()
        body.fill()

        palette.canvas.setFill()
        let eyeRadius = max(1.4, box.width * 0.055)
        for x in [box.minX + box.width * 0.39, box.minX + box.width * 0.63] {
            NSBezierPath(ovalIn: NSRect(x: x, y: box.minY + box.height * 0.53, width: eyeRadius * 2, height: eyeRadius * 2)).fill()
        }

        palette.accent.setStroke()
        let scarf = NSBezierPath()
        scarf.lineWidth = max(1.1, box.width * 0.045)
        scarf.lineCapStyle = .round
        scarf.move(to: NSPoint(x: box.minX + box.width * 0.29, y: box.minY + box.height * 0.27))
        scarf.curve(to: NSPoint(x: box.minX + box.width * 0.72, y: box.minY + box.height * 0.28), controlPoint1: NSPoint(x: box.minX + box.width * 0.4, y: box.minY + box.height * 0.18), controlPoint2: NSPoint(x: box.minX + box.width * 0.62, y: box.minY + box.height * 0.18))
        scarf.stroke()
    }

    func acknowledgeSuccess() {
        guard !isPaused, !NSWorkspace.shared.accessibilityDisplayShouldReduceMotion else { return }
        wantsLayer = true
        let hop = CAKeyframeAnimation(keyPath: "transform.translation.y")
        hop.values = [0, 3, 0]
        hop.keyTimes = [0, 0.4, 1]
        hop.duration = 0.27
        hop.timingFunctions = [CAMediaTimingFunction(name: .easeOut), CAMediaTimingFunction(name: .easeInEaseOut)]
        layer?.add(hop, forKey: "successHop")
    }
}

// Appearance observation stays event-driven; there is no idle polling.
final class PipCanvasView: NSView {
    var appearanceChanged: (() -> Void)?
    override func viewDidChangeEffectiveAppearance() {
        super.viewDidChangeEffectiveAppearance()
        appearanceChanged?()
    }
}

final class PipActionButton: NSButton {
    var palette = PipPalette.make(theme: .paper, dark: false) { didSet { updateStyle() } }
    var primary = false { didSet { updateStyle() } }
    override var isEnabled: Bool { didSet { updateStyle() } }
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        isBordered = false
        wantsLayer = true
        layer?.cornerRadius = 17
        heightAnchor.constraint(greaterThanOrEqualToConstant: 34).isActive = true
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) is unavailable") }
    func updateStyle() {
        let ink = isEnabled ? palette.ink : palette.secondary
        layer?.backgroundColor = (primary ? palette.ink : palette.canvas).cgColor
        layer?.borderWidth = primary ? 0 : 1
        layer?.borderColor = palette.secondary.withAlphaComponent(0.35).cgColor
        let color = primary ? palette.canvas : ink
        attributedTitle = NSAttributedString(string: title, attributes: [.foregroundColor: color, .font: NSFont.systemFont(ofSize: 13, weight: .medium)])
        alphaValue = isEnabled ? 1 : 0.55
        needsDisplay = true
    }
}
