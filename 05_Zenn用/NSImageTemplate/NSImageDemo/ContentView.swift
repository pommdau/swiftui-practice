import SwiftUI

/// プラットフォームに適したカタログを選択するルート画面。
struct ContentView: View {
    var body: some View {
        #if os(macOS)
        NSImageCatalogView()
        #elseif os(iOS)
        UIImageContentView()
        #endif
    }
}

#Preview {
    ContentView()
}
