#  README.md
## 参考
- [swift\-studying/wwdc2019/Font Management and Text Scaling\.md](https://github.com/pommdau/swift-studying/blob/4525aba6a35bf4aba56f6dae93364b54c03c1b5a/wwdc2019/Font%20Management%20and%20Text%20Scaling.md)
- [CTFontManagerRegisterFontURLs](https://developer.apple.com/documentation/coretext/3227897-ctfontmanagerregisterfonturls?language=objc)

https://user-images.githubusercontent.com/29433103/177080865-feed0c5a-8c22-43bc-b76b-d55e1ff1dfd8.mov

## 疑問
- WWDC2019のビデオ内であった設定からフォントを削除した場合のNotificationは検知できなかった。
- 使い方間違ってる？

```swift
.onAppear {
    NotificationCenter.default.addObserver(
        self,
        selector: #selector(helper.fontsChangedNotification(_:)) ,
        name: kCTFontManagerRegisteredFontsChangedNotification as NSNotification.Name,
        object: nil)
    updateFontStatus()
}
```

- また有効期限の設定は`Info.plist`に`FontProviderSubscriptionSupportInfo`を記述することで実現できるらしい。
- これに関するドキュメントが皆無でQiita記事があるのみ。Appleに技術フォーラム等で聞かないといけないのかもしれない。
