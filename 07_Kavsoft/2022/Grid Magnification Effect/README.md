# [Grid Magnification Effect \- Animation Challenge \- Xcode 14 \- SwiftUI Tutorials](https://www.youtube.com/watch?v=xyv_J977B1E)
- `@Gesture`の話など。ドラッグ終了時に値が0に戻る。戻したくない場合は`@State`を使えば良い。
    - [Working with SwiftUI Gestures and @GestureState](https://www.appcoda.com/swiftui-gestures/)
- `.mask`
    - [【SwiftUI】Viewの切り取りとマスク](https://capibara1969.com/1939/)
- `.animation`
    - [animation\(\_:value:\)](https://developer.apple.com/documentation/swiftui/path/animation(_:value:))
- [CGRectApplyAffineTransform\(\_:\_:\)](https://developer.apple.com/documentation/coregraphics/1455875-cgrectapplyaffinetransform)
    - [CGAffineTransform](https://developer.apple.com/documentation/corefoundation/cgaffinetransform)

```swift
let transformedLocation = location.applying(
    .init(scaleX: scale, y: scale)
)
```