import SwiftUI

/// 両プラットフォームで共通の画像・説明・Swift名の表示。
struct ImageCatalogRow: View {
    let image: Image?
    let symbol: String
    let label: String

    var body: some View {
        HStack(spacing: 12) {
            thumbnail
                .frame(width: 32, height: 32)
            VStack(alignment: .leading, spacing: 4) {
                Text(label)
                Text(symbol)
                    .font(.system(.caption, design: .monospaced))
                    .foregroundStyle(.secondary)
                    .textSelection(.enabled)
            }
        }
        .padding(.vertical, 4)
    }

    @ViewBuilder
    private var thumbnail: some View {
        if let image {
            image
                .resizable()
                .scaledToFit()
                .accessibilityHidden(true)
        } else {
            Image(systemName: "questionmark.square")
                .accessibilityLabel("画像を取得できません")
        }
    }
}
