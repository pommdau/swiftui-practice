## PanAndDismissDemo

- [SwiftUIでパンで半透明にしながら画面を閉じる実装](https://zenn.dev/ikeh1024/articles/e4f4830f27e563)

https://user-images.githubusercontent.com/29433103/172553180-bded1343-8047-4cc0-9937-7a7a9333630a.mov

## Usage sample code

```swift
import SwiftUI

struct ContentView: View {
    
    @State private var showingModal = false
    
    private let imageName = "image01"
    
    var body: some View {
        ZStack {
            if showingModal {
                Image(imageName)
                    .resizable()
                    .frame(width: 300, height: 300)
                    .modifier(PanAndDismissModifier(showingModal: $showingModal))  // This modifier!
                .zIndex(1)  // Bring to the front like a modal sheet
            }
            Button {
                withAnimation() {
                    showingModal = true
                }
            } label: {
                Image(imageName)
                    .resizable()
                    .frame(width: 200, height: 200)
            }
        }
    }
}
```
