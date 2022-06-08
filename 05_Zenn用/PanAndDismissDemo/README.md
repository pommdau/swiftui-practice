## PanAndDismissDemo

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
                .zIndex(1)
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
