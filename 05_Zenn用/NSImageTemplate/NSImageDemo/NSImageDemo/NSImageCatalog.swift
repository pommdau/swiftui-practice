#if os(macOS)
import AppKit

struct StandardImage: Identifiable {
    let name: NSImage.Name
    let symbol: String
    let label: String
    let isTouchBar: Bool

    var id: String { symbol }

    static let sections: [StandardImageSection] = [
        .init(title: "一般用", items: all.filter { !$0.isTouchBar }),
        .init(title: "Touch Bar用", items: all.filter { $0.isTouchBar })
    ]
}

struct StandardImageSection: Identifiable {
    let title: String
    let items: [StandardImage]

    var id: String { title }
}
#endif
