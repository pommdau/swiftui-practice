## iOSの定義済み標準画像（UIImage）

iOSではAppKitの`NSImage`ではなく、UIKitの`UIImage`を使います。UIImageにも、文字列の画像名を指定せずに取得できる定義済み標準画像があります。

### 定義済み画像の一覧

| シンボル名 | 説明 |
| --- | --- |
| `UIImage.add` | コンテンツの追加 |
| `UIImage.remove` | コンテンツの削除 |
| `UIImage.actions` | ユーザが実行するアクション |
| `UIImage.checkmark` | 塗りつぶされた円背景のチェックマーク |
| `UIImage.strokedCheckmark` | 色付きの円と白い縁取りのチェックマーク |

これらはすべてiOS 13以降で利用できる型プロパティで、戻り値は非オプショナルの`UIImage`です。

### iOSアプリでの表示例

以下は提供されたスクリーンショットです。上から`UIImage.add`、`UIImage.remove`、`UIImage.actions`、`UIImage.checkmark`、`UIImage.strokedCheckmark`の順に表示されています。個別の画像を書き出したものではなく、5種類を一覧表示した画面です。色や外観は表示環境・設定により変わる場合があります。

![iOSアプリで表示したUIImageの定義済み標準画像5種類](images/UIImage-standard-images-ios.png)

### SwiftUIで表示する

```swift
import SwiftUI
import UIKit

struct AddImageView: View {
    var body: some View {
        Image(uiImage: .add)
            .accessibilityLabel("追加")
    }
}
```

### UIKitのボタンで使用する

```swift
import UIKit

let button = UIButton(type: .system)
button.setImage(.add, for: .normal)
button.accessibilityLabel = "追加"

// 画像単体でも取得できます。
let image: UIImage = .checkmark
```

### SF Symbolsとの使い分け

上記5種類は、標準の用途に対応した画像を型プロパティで取得するAPIです。より幅広いアイコンを選ぶ場合は、SF Symbolsを名前で取得できます。こちらの戻り値はオプショナルです。

```swift
// UIKit
let folderImage = UIImage(systemName: "folder")

// SwiftUI（macOS・iOS共通）
Image(systemName: "folder")
```

AppKitの`NSImage.addTemplateName`はUIKitの画像名ではありません。iOSで追加を表したい場合は、`UIImage.add`やSF Symbolsの`"plus"`などを用途に応じて選びます。同じ見た目を保証する一対一の対応ではありません。

### 確認環境・公式資料

2026年11月11日にXcode 27.2（27B52）のiOS SDKにある`UIKit.framework/Headers/UIImage.h`を確認しました。`UIImage (PreconfiguredSystemImages)`に上記5種類が宣言されています。Objective-Cでは`addImage`、Swiftでは`UIImage.add`のような名前になります。

この5件はUIImageの定義済み標準画像の件数で、利用できるSF Symbols全体の件数ではありません。APIの対応OSとプロジェクト自体の最低対応OSも異なります。本プロジェクトのiOS Deployment Targetは27.2です。

- [UIImage — Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uiimage)
- [strokedCheckmark — Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uiimage/strokedcheckmark)
- [init(systemName:) — Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uiimage/init(systemname:))
