#if os(iOS)
import UIKit

struct StandardUIImage: Identifiable {
    let image: UIImage
    let symbol: String
    let label: String

    var id: String { symbol }

    static let all: [StandardUIImage] = [
        .init(image: .add, symbol: "UIImage.add", label: "コンテンツの追加"),
        .init(image: .remove, symbol: "UIImage.remove", label: "コンテンツの削除"),
        .init(image: .actions, symbol: "UIImage.actions", label: "アクション"),
        .init(image: .checkmark, symbol: "UIImage.checkmark", label: "塗りつぶされた円背景のチェックマーク"),
        .init(image: .strokedCheckmark, symbol: "UIImage.strokedCheckmark", label: "色付きの円と白い縁取りのチェックマーク")
    ]

}
#endif
