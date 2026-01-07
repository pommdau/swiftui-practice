#if os(iOS)
import SwiftUI

struct UIImageContentView: View {
    private let items = StandardUIImage.all

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(items) { item in
                        ImageCatalogRow(
                            image: Image(uiImage: item.image),
                            symbol: item.symbol,
                            label: item.label
                        )
                    }
                } header: {
                    Text("定義済みの標準画像（\(items.count)種類）")
                } footer: {
                    Text("iOS 13以降で利用できるUIImageの型プロパティです。画像名の文字列を指定せずに取得できます。")
                }
            }
            .navigationTitle("UIKitのシステム画像")
        }
    }
}
#endif
