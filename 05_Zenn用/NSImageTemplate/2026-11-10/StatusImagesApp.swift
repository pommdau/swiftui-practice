import AppKit
import SwiftUI

@main
struct StatusImagesApp: App {
    var body: some Scene {
        WindowGroup("システム画像一覧") {
            ContentView()
        }
        .defaultSize(width: 560, height: 680)
    }
}

struct ContentView: View {
    private let items: [StatusImage] = [
        .init(name: NSImage.actionTemplateName, symbol: "actionTemplateName", label: "アクションメニュー"),
        .init(name: NSImage.addTemplateName, symbol: "addTemplateName", label: "項目追加"),
        .init(name: NSImage.advancedName, symbol: "advancedName", label: "詳細な環境設定"),
        .init(name: NSImage.applicationIconName, symbol: "applicationIconName", label: "アプリのアイコン"),
        .init(name: NSImage.bluetoothTemplateName, symbol: "bluetoothTemplateName", label: "Bluetooth"),
        .init(name: NSImage.bonjourName, symbol: "bonjourName", label: "Bonjour"),
        .init(name: NSImage.bookmarksTemplateName, symbol: "bookmarksTemplateName", label: "ブックマーク"),
        .init(name: NSImage.cautionName, symbol: "cautionName", label: "注意"),
        .init(name: NSImage.colorPanelName, symbol: "colorPanelName", label: "カラーパネル"),
        .init(name: NSImage.columnViewTemplateName, symbol: "columnViewTemplateName", label: "カラム表示"),
        .init(name: NSImage.computerName, symbol: "computerName", label: "コンピュータ"),
        .init(name: NSImage.enterFullScreenTemplateName, symbol: "enterFullScreenTemplateName", label: "フルスクリーン開始"),
        .init(name: NSImage.everyoneName, symbol: "everyoneName", label: "全ユーザ"),
        .init(name: NSImage.exitFullScreenTemplateName, symbol: "exitFullScreenTemplateName", label: "フルスクリーン解除"),
        .init(name: NSImage.flowViewTemplateName, symbol: "flowViewTemplateName", label: "カバーフロー表示"),

        .init(name: NSImage.statusAvailableName,
              symbol: "statusAvailableName", label: "利用可能"),
        .init(name: NSImage.statusPartiallyAvailableName,
              symbol: "statusPartiallyAvailableName", label: "一部利用可能"),
        .init(name: NSImage.statusUnavailableName,
              symbol: "statusUnavailableName", label: "利用不可"),
        .init(name: NSImage.statusNoneName,
              symbol: "statusNoneName", label: "状態なし")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("AppKitのシステム画像")
                .font(.title2.bold())

            List(items) { item in
                HStack(spacing: 12) {
                    if let image = NSImage(named: item.name) {
                        Image(nsImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                            .accessibilityHidden(true)
                    } else {
                        Image(systemName: "questionmark.square")
                            .frame(width: 24, height: 24)
                            .accessibilityLabel("画像を取得できません")
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.label)
                        Text("NSImage.\(item.symbol)")
                            .font(.system(.caption, design: .monospaced))
                            .foregroundStyle(.secondary)
                            .textSelection(.enabled)
                    }
                }
                .padding(.vertical, 4)
            }
            .listStyle(.inset)
        }
        .padding()
        .frame(minWidth: 440, minHeight: 300)
    }
}

private struct StatusImage: Identifiable {
    let name: NSImage.Name
    let symbol: String
    let label: String

    var id: String { symbol }
}
