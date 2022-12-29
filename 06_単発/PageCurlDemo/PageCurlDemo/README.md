#  Memos
## PageCurlのアイディア
- [nachonavarro/Pages](https://github.com/nachonavarro/Pages)
- バグと修正
    - [Fix the double animation issue \#20](https://github.com/nachonavarro/Pages/pull/20/files)
        - とりあえずこれで直りはする
    - [Page change animated twice \#18](https://github.com/nachonavarro/Pages/issues/18)

## SwiftUIからUIKitを使う
- [UIViewRepresentable を理解して SwiftUI の足りないところを UIKit で補う](https://qiita.com/maiyama18/items/e36608af7e39f81af01c#coordinator)

## Viewのみに影をつける
- [【SwiftUI】Viewに影をつける（shadow）](https://capibara1969.com/2017/)

>.compositingGroup()は、VIewの複数の要素をグループ化して１つにまとめる意味があります。

```swift 
struct ContentView: View {
    var body: some View {
        Text("カピ通信")
            .font(.largeTitle)
            .padding()
            .background(Color.yellow)
            .compositingGroup()        // Viewの要素をグループ化
            .shadow(color: .gray, radius: 3, x: 10, y: 10)
    }
}
 
```

## TextFieldの行制限
- [How do I create a multiline TextField in SwiftUI?](https://stackoverflow.com/questions/56471973/how-do-i-create-a-multiline-textfield-in-swiftui)

## Ratio Width
- [Weighted Layout \(HStack and VStack\) in SwiftUI](https://swiftuirecipes.com/blog/weighted-layout-hstack-and-vstack-in-swiftui)

## その他
- アニメーションの自前実装で役に立つかも
    - [Turn a page like a Book with UIView?](https://stackoverflow.com/questions/477078/turn-a-page-like-a-book-with-uiview)
    - [iBook Image Curl Animation on iOS](https://stackoverflow.com/questions/39222887/ibook-image-curl-animation-on-ios)
    - [Split82/HMGLTransitions](https://github.com/Split82/HMGLTransitions/tree/master/Classes)
    - [Building an iPad Reader for War of the Worlds](https://code.tutsplus.com/tutorials/building-an-ipad-reader-for-emwar-of-the-worldsem--mobile-7406)
    - [How do I create a custom page curl Core Animation?](https://stackoverflow.com/questions/1489061/how-do-i-create-a-custom-page-curl-core-animation)
    
