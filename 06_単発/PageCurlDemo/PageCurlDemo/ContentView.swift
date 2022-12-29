import SwiftUI

struct ContentView: View {
    
    @State private var currentPage = 0
    
    var body: some View{
        
        VStack {
            Pages(currentPage: $currentPage,
                  transitionStyle: .pageCurl,
                  hasControl: false) {
                StickyView()
                Rectangle()
                    .foregroundColor(Color.black.opacity(0.01))
                    .onAppear() {
                        print("🐱")
                    }
            }
            .frame(width: 300, height: 200)
                                    
            StickyView()
                .frame(width: 200, height: 100)
            StickyView()
                .frame(width: 200, height: 100)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

