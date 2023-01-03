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
    - [Implementing iBooks page curling using a conical deformation algorithm](http://wdnuon.blogspot.com/2010/05/implementing-ibooks-page-curling-using.html)
    - [Turn a page like a Book with UIView?](https://stackoverflow.com/questions/477078/turn-a-page-like-a-book-with-uiview)
    - [iBook Image Curl Animation on iOS](https://stackoverflow.com/questions/39222887/ibook-image-curl-animation-on-ios)
    - [Split82/HMGLTransitions](https://github.com/Split82/HMGLTransitions/tree/master/Classes)
    - [Building an iPad Reader for War of the Worlds](https://code.tutsplus.com/tutorials/building-an-ipad-reader-for-emwar-of-the-worldsem--mobile-7406)
    - [How do I create a custom page curl Core Animation?](https://stackoverflow.com/questions/1489061/how-do-i-create-a-custom-page-curl-core-animation)
    - [A Page Turn Effect Using C\#](https://www.codeproject.com/Articles/13202/A-Page-Turn-Effect-Using-C)
    - [App Store\-Safe Page Curl Animations](https://oleb.net/blog/2010/06/app-store-safe-page-curl-animations/)
    
```swift
UIView.animate(withDuration: 1.0, animations: {
            let animation = CATransition()
            animation.duration = 1.2
            animation.startProgress = 0.0
            animation.endProgress = 0.6
            animation.type = CATransitionType(rawValue: "pageCurl")
            animation.subtype = CATransitionSubtype(rawValue: "fromRight")
            animation.isRemovedOnCompletion = false
            animation.fillMode = CAMediaTimingFillMode(rawValue: "extended")
            animation.isRemovedOnCompletion = false
            if let animation = animation as? CATransition{
                self.view.layer.add(animation, forKey: "pageFlipAnimation")
                self.viewDidLoad()
            }
        })
```

## 削除処理
- [SwiftUI out of index when deleting an array element in ForEach](https://stackoverflow.com/questions/61430999/swiftui-out-of-index-when-deleting-an-array-element-in-foreach)
- [【SwiftUI】ObservableObjectを階層構造で使う](https://capibara1969.com/3598/)

## ドラッグ処理
- [\[SwiftUI\] ドラッグによりViewを移動させるときに気をつけること](https://software.small-desk.com/development/2020/05/18/tips-swiftui-viewdrag/)
- 子ビューの中のときは`DragGesture(coordinateSpace: .global)`のように指定しないといけない？
    - [SwiftUI DragGesture sets offset in infinite loop \[duplicate\]](https://stackoverflow.com/questions/69563958/swiftui-draggesture-sets-offset-in-infinite-loop)
