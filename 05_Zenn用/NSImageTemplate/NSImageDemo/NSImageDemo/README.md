# NSImageDemo

AppKitの名前付き標準画像とUIKitの定義済み標準画像をSwiftUIで表示するmacOS・iOSアプリです。画像、日本語の用途名、Swiftの定数名を一覧で確認できます。

## 画像付きの全定数一覧

[NSImage 標準画像一覧](../docs/NSImage-catalog.md)に、SDKの画像名定数139件を`|画像|シンボル名|説明|`の表でまとめています。PNG画像は`../docs/images/`に保存しています。

同じ一覧のiOSの節に、UIImage 5種類の定義・利用例と、提供されたアプリ画面のスクリーンショットも掲載しています。

シンボル名にはSwiftの定数名（例：`NSImage.statusAvailableName`）を使用しています。一般用とTouch Bar用は別の表に分けています。

プロジェクトディレクトリ（`NSImageDemo.xcodeproj`のある場所）で以下を実行すると、選択中のXcodeのSDKから画像とMarkdownを再生成できます。Python 3、Xcodeのコマンドラインツール、macOSのAppKitを使用し、追加のPythonパッケージは不要です。

```sh
python3 scripts/export_images.py
```

PNGは白背景の96 × 96ピクセルで、テンプレート画像は黒で描画します。OSや実行環境によって外観や取得結果が変わる場合があります。

## 実行方法

1. `NSImageDemo.xcodeproj`をXcodeで開きます。
2. スキーム`NSImageDemo`を選択し、macOSでは`My Mac`、iOSではiPhone・iPadの実機またはシミュレータを実行先に指定します。
3. Run（⌘R）で実行します。

現在のプロジェクト設定はmacOS 27.2以降・iOS 27.2以降を対象としています。確認に使用した環境はXcode 27.2（ビルド番号27B52）です。

## iOSの定義済みUIImage

macOSではNSImage全139種類、iOSでは以下のUIImage全5種類を表示します。各行に画像、日本語の説明、Swiftの名前を表示します。AppKitとUIKitは条件付きコンパイルで分けています。

| Swiftの名前 | 説明 |
| --- | --- |
| `UIImage.add` | コンテンツの追加 |
| `UIImage.remove` | コンテンツの削除 |
| `UIImage.actions` | ユーザが実行するアクション |
| `UIImage.checkmark` | 塗りつぶされた円背景のチェックマーク |
| `UIImage.strokedCheckmark` | 色付きの円と白い縁取りのチェックマーク |

### SDKでの定義確認

2026年11月11日に、Xcode 27.2（27B52）のiOS SDKの`UIKit.framework/Headers/UIImage.h`を確認しました。`UIImage (PreconfiguredSystemImages)`に上記5種類のクラスプロパティが宣言されています。Objective-Cでは`addImage`、Swiftでは`UIImage.add`のような名前になります。

いずれもiOS 13以降で利用可能で、戻り値は非オプショナルの`UIImage`です。アプリ自体の最低対応OSは上記プロジェクト設定に従います。これら5種類は、利用できるSF Symbols全体の件数ではありません。より多くのシンボルには`UIImage(systemName:)`を利用します。

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

// 画像単体でも取得できます（オプショナルではありません）。
let image: UIImage = .checkmark

// SF Symbolsを名前で取得する場合はオプショナルです。
let folderImage = UIImage(systemName: "folder")
```

`NSImage`はmacOSのAppKit、`UIImage`はiOSのUIKitが提供する別のクラスです。`NSImage.addTemplateName`を`UIImage(named:)`に渡すことはできません。

参考：[UIImageの標準画像（Apple公式）](https://developer.apple.com/documentation/uikit/uiimage)、[strokedCheckmark（Apple公式）](https://developer.apple.com/documentation/uikit/uiimage/strokedcheckmark)。

## macOSで表示する画像

Xcode 27.2のSDKに定義された全139種類を、一般用62種類とTouch Bar用77種類のセクションに分けて表示します。以下の表は代表的な19種類です。

| Swiftの定数（`NSImage.`を省略） | 用途 |
| --- | --- |
| `actionTemplateName` | アクションメニュー |
| `addTemplateName` | 項目追加 |
| `advancedName` | 詳細な環境設定 |
| `applicationIconName` | アプリのアイコン |
| `bluetoothTemplateName` | Bluetooth |
| `bonjourName` | Bonjour |
| `bookmarksTemplateName` | ブックマーク |
| `cautionName` | 注意 |
| `colorPanelName` | カラーパネル |
| `columnViewTemplateName` | カラム表示 |
| `computerName` | コンピュータ |
| `enterFullScreenTemplateName` | フルスクリーン開始 |
| `everyoneName` | 全ユーザ |
| `exitFullScreenTemplateName` | フルスクリーン解除 |
| `flowViewTemplateName` | カバーフロー表示 |
| `statusAvailableName` | 利用可能（基本色：緑） |
| `statusPartiallyAvailableName` | 一部利用可能（基本色：黄） |
| `statusUnavailableName` | 利用不可（基本色：赤） |
| `statusNoneName` | 状態なし（基本色：グレー） |

## 標準画像の取得と表示

```swift
import AppKit
import SwiftUI

if let image = NSImage(named: NSImage.statusAvailableName) {
    Image(nsImage: image)
}
```

`NSImage.statusAvailableName`などは画像の名前を表す定数です。`NSImage(named:)`は指定名の画像を取得し、取得できなければ`nil`を返します。このアプリでは取得に失敗した場合、疑問符の代替画像を表示します。

ステータス画像は状態を表現するための表示素材であり、ネットワーク接続などの状態を自動判定するAPIではありません。

名前に`Template`を含む画像は、主に形を使うテンプレート画像です。対応するコントロールでは外観や表示状態に応じた描画に使われます。これらの名前付き標準画像は、`Image(systemName: "plus")`などで使うSF Symbolsとは別の画像群です。

## Xcode 27.2での画像名定数の確認

確認日：2026年11月10日。

インストール済みのXcodeに含まれるmacOS SDKの`NSImage.h`を読み、`APPKIT_EXTERN NSImageName const`で宣言される画像名定数を確認しました。

| 確認対象 | 画像名定数の宣言数 |
| --- | ---: |
| 過去のメモ：Xcode 16.4 RCのSDK | 139件 |
| インストール済み：Xcode 27.0 beta 4のSDK | 139件 |
| インストール済み：Xcode 27.2（27B52）のSDK | 139件 |

Xcode 27.2でも宣言数は139件で、各定数の`API_AVAILABLE`に記載されたmacOSの導入バージョンは10.5、10.6、10.8、10.12、10.12.2、10.13でした。この確認範囲では、新しいmacOSで導入された画像名定数の追加は見当たりませんでした。

ただし、Xcode 16.4 RCの139件は既存メモの記録との比較です。旧SDKとの定数名の全件差分比較は実施していません。また、この件数は名前付き標準画像の定数宣言数であり、SF Symbolsの数やOS内部の全画像数を示すものではありません。

Appleのリリース一覧では、確認日時点の最新正式版はXcode 27.2（2026年10月29日公開）、最新ベータ版はXcode 27.3 beta（2026年11月3日公開）でした。27.3 betaはこのMacに未導入のため、そのSDKの画像名定数は未確認です。

### 定義場所と再確認方法

SDK内の相対パス：

```text
System/Library/Frameworks/AppKit.framework/Headers/NSImage.h
```

今回確認したXcode 27.2のヘッダー：

```text
/Applications/Xcode-27.2.0.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks/AppKit.framework/Headers/NSImage.h
```

ターミナルでは、選択中のXcodeとSDKを確認してから宣言を検索できます。以下は`rg`（ripgrep）が利用できる環境向けです。

```sh
xcodebuild -version
xcrun --show-sdk-path

sdk_path="$(xcrun --show-sdk-path)"
rg '^APPKIT_EXTERN NSImageName\s+const\s+' \
  "$sdk_path/System/Library/Frameworks/AppKit.framework/Headers/NSImage.h"

# 宣言の行数を数える
rg -c '^APPKIT_EXTERN NSImageName\s+const\s+' \
  "$sdk_path/System/Library/Frameworks/AppKit.framework/Headers/NSImage.h"
```

ヘッダーには画像名の宣言があり、画像データ自体が含まれているわけではありません。たとえばObjective-Cの`NSImageNameStatusAvailable`は、Swiftでは`NSImage.statusAvailableName`として参照します。Xcodeで定数を⌘クリックし、Jump to DefinitionからSwift向けの定義を確認することもできます。

## ファイル構成

- `NSImageDemo/MyApp.swift`：アプリのエントリーポイント。ウィンドウタイトルと初期サイズ（560 × 680）を指定します。
- `NSImageDemo/ContentView.swift`：OSに応じて一覧画面を選択するルート画面。
- `NSImageDemo/ImageCatalogRow.swift`：画像・説明・Swift名を表示する両OS共通の行。
- `NSImageDemo/NSImageCatalogView.swift`：macOS向けの全139種類の一覧画面。
- `NSImageDemo/NSImageCatalog.swift`：macOSの画像モデルとセクション定義。
- `NSImageDemo/StandardImage.swift`：一覧用の全139種類の画像データ。書き出しスクリプトで再生成します。
- `NSImageDemo/UIImageContentView.swift`：iOS向けのUIImage 5種類の一覧画面。
- `NSImageDemo/StandardUIImage.swift`：iOSの画像モデルと5種類のデータ。
- `scripts/export_images.py`：PNG、Markdown、macOSの画像データを生成。
- `scripts/usage-example.md`：生成Markdownに掲載するSwiftサンプル。
- `scripts/uiimage-guide.md`：画像一覧に追記するiOSのUIImage解説。
- `NSImageDemo.xcodeproj`：macOS・iOS向けのプロジェクト設定。
- 元資料：`../2026-11-10/NSImage-notes.md`、`../2026-11-10/StatusImagesApp.swift`。

## 検証状況

Xcode 27.2で、署名を無効にしたmacOS向け・iOS Simulator向けのDebugビルドの成功を確認しました。アプリの起動および画面の目視確認は未実施です。

プロジェクトディレクトリでのビルド例：

```sh
xcodebuild \
  -project NSImageDemo.xcodeproj \
  -scheme NSImageDemo \
  -configuration Debug \
  -destination 'generic/platform=macOS' \
  -derivedDataPath /private/tmp/NSImageDemoDerivedData \
  CODE_SIGNING_ALLOWED=NO \
  build
```

## 参考資料

- [NSImage — Apple Developer Documentation](https://developer.apple.com/documentation/appkit/nsimage)
- [statusAvailableName — Apple Developer Documentation](https://developer.apple.com/documentation/appkit/nsimage/statusavailablename)
- [Apple Developerのリリース一覧](https://developer.apple.com/news/releases/)
- [Xcode 27.2のセキュリティ情報（公開日の確認）](https://support.apple.com/en-us/149589)
