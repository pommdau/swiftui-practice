import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        #if os(macOS)
        WindowGroup("システム画像一覧") {
            ContentView()
        }
        .defaultSize(width: 560, height: 680)
        #elseif os(iOS)
        WindowGroup {
            ContentView()
        }
        #endif
    }
}
