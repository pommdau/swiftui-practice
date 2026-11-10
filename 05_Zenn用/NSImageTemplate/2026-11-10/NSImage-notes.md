# AppKitの標準画像とNSStatusAvailable

## NSStatusAvailableとは

`NSStatusAvailable`は、macOSのAppKitが提供する「利用可能・正常」を表す標準画像の名前。Swiftでは`NSImage.statusAvailableName`を使って取得する。

```swift
import AppKit

let image = NSImage(named: NSImage.statusAvailableName)
```

これは表示用の画像であり、ネットワーク接続などの状態を自動判定するAPIではない。

| Swiftの定数 | 表す状態 | 基本的な色 |
| --- | --- | --- |
| `NSImage.statusAvailableName` | 利用可能 | 緑 |
| `NSImage.statusPartiallyAvailableName` | 一部利用可能 | 黄 |
| `NSImage.statusUnavailableName` | 利用不可 | 赤 |
| `NSImage.statusNoneName` | 状態なし | グレー |

## NSImageの標準画像とは

macOSが用意している画像で、ボタン、ツールバー、状態表示などに使える。自分で画像ファイルを用意せず、画像名の定数から取得できる。

```swift
let image = NSImage(named: NSImage.addTemplateName)
```

- `NSImage`：画像を扱うクラス。
- `NSImage.addTemplateName`：標準画像の名前を表す定数。
- `NSImage(named:)`：指定した名前の画像を取得するイニシャライザ。取得できなければ`nil`を返す。

名前に`Template`がある画像は、主に形を使うテンプレート画像。対応するコントロールでは、外観や表示状態に合わせた描画に使われる。

これらの名前付き標準画像と、`Image(systemName: "plus")`などで使うSF Symbolsは、別の画像群である。

## 会話で挙がったSystemイメージ

以下は標準画像全体の一部。

| Swiftの定数（`NSImage.`を省略） | 用途 |
| --- | --- |
| `actionTemplateName` | アクションメニュー |
| `addTemplateName` | 項目追加 |
| `advancedName` | 詳細な環境設定のツールバーアイコン |
| `applicationIconName` | アプリのアイコン |
| `bluetoothTemplateName` | Bluetooth |
| `bonjourName` | Bonjour |
| `bookmarksTemplateName` | ブックマーク |
| `cautionName` | 注意喚起 |
| `colorPanelName` | カラーパネルのツールバーアイコン |
| `columnViewTemplateName` | カラム表示 |
| `computerName` | コンピュータ |
| `enterFullScreenTemplateName` | フルスクリーン開始 |
| `everyoneName` | 全ユーザの権限 |
| `exitFullScreenTemplateName` | フルスクリーン解除 |
| `flowViewTemplateName` | カバーフロー表示 |

ほかにも、フォルダ、ゴミ箱、ネットワーク、鍵、更新、削除、共有、Touch Bar向けなどの画像がある。

## 一覧の定義場所

公開されている画像名定数の宣言は、macOS SDKの`NSImage.h`にある。このヘッダーは名前の宣言を含むもので、画像データそのものを含むわけではない。

SDK内の相対パス：

```text
MacOSX.sdk/System/Library/Frameworks/AppKit.framework/Headers/NSImage.h
```

今回確認した環境の絶対パス：

```text
/Applications/Xcode-16.4.0-Release.Candidate.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks/AppKit.framework/Headers/NSImage.h
```

この環境のヘッダーには、`APPKIT_EXTERN NSImageName`で始まる画像名定数の宣言が139個ある。これはこのSDKでの件数であり、すべてのmacOS・SDKに共通する固定数ではない。

宣言の例：

```objc
APPKIT_EXTERN NSImageName const NSImageNameStatusAvailable
    API_AVAILABLE(macos(10.6));
```

Swiftでは、これが`NSImage.statusAvailableName`として公開される。

使用中のSDKのパスは、ターミナルで次のコマンドから確認できる。

```sh
xcrun --show-sdk-path
```

Xcodeでは`NSImage.statusAvailableName`を⌘クリックし、Jump to DefinitionでSwift向けの定義を確認できる。

## 作成したサンプル

[StatusImagesApp.swift](StatusImagesApp.swift)

- macOS向けのSwiftUIアプリ。
- 上記のSystemイメージ15種類とステータス画像4種類、合計19種類を表示する。
- 各行に画像、日本語名、Swiftの定数名を表示する。
- 標準画像すべてを網羅するサンプルではない。
- この環境で`swiftc`によるコンパイルを確認済み。画面表示の目視確認は未実施。

利用する場合は、XcodeでmacOSのApp（SwiftUI）プロジェクトを作成し、生成されたAppとContentViewの定義をサンプルの内容で置き換える。`@main`が重複しないようにする。

## 公式ドキュメント

- [NSImage](https://developer.apple.com/documentation/appkit/nsimage)
- [statusAvailableName](https://developer.apple.com/documentation/appkit/nsimage/statusavailablename)
