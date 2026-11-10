## Swiftでの利用例

表のシンボル名を`NSImage(named:)`に渡して取得します。画像が取得できない場合に備えて、オプショナルを処理してください。

### SwiftUIで表示する

```swift
import AppKit
import SwiftUI

struct AddImageView: View {
    var body: some View {
        if let image = NSImage(named: NSImage.addTemplateName) {
            Image(nsImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .accessibilityLabel("追加")
        } else {
            Text("画像を取得できません")
        }
    }
}
```

### AppKitのボタンに設定する

```swift
import AppKit

let button = NSButton(title: "追加", target: nil, action: nil)
button.image = NSImage(named: NSImage.addTemplateName)
button.imagePosition = .imageLeading
```

ステータス画像なども同じ方法で取得できます。

```swift
let availableImage = NSImage(named: NSImage.statusAvailableName)
```

Touch Bar用の画像も取得方法は同じですが、本来は`NSTouchBar`内で利用する画像です。このサンプルアプリでは画像一覧の確認用に表示しています。

