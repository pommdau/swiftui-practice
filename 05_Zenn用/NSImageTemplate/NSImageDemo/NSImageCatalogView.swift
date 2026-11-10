#if os(macOS)
import AppKit
import SwiftUI

struct NSImageCatalogView: View {
    private let sections = StandardImage.sections

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("AppKitのシステム画像")
                .font(.title2.bold())
            List {
                ForEach(sections) { section in
                    Section("\(section.title)（\(section.items.count)種類）") {
                        ForEach(section.items) { item in
                            ImageCatalogRow(
                                image: NSImage(named: item.name).map { Image(nsImage: $0) },
                                symbol: item.symbol,
                                label: item.label
                            )
                        }
                    }
                }
            }
            .listStyle(.inset)
        }
        .padding()
        .frame(minWidth: 440, minHeight: 300)
    }
}
#endif
