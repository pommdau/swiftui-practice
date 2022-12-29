import SwiftUI

struct ContentView: View {
    
    @State private var currentPage = 0
    
    var body: some View{
        GeometryReader { geometry in
                Pages(currentPage: $currentPage,
                      transitionStyle: .pageCurl,
                      hasControl: false) {
                    StickyView(sticky: .init(message: "HogeHoge", positon: .init(x: 100, y: 40)))
                    Rectangle()
                        .foregroundColor(Color.black.opacity(0.01))
                        .onAppear() {
                            print("🐱")
                        }
                }
                      .frame(width: 300, height: 200)
                      .offset(.init(width: 0, height: 0))
                
                StickyView(sticky: .init(message: "HogeHoge", positon: .init(x: 0, y: 300)))
                    .frame(width: 200, height: 100)
                    .offset(.init(width: 20, height: 200))
                StickyView(sticky: .init(message: "HogeHoge", positon: .init(x: 100, y: 200)))
                    .frame(width: 200, height: 100)
                    .offset(.init(width: 0, height: 350))

        }
        .background(.red.opacity(0.1))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

