import SwiftUI

struct ContentView: View {
    var body: some View {

        GeometryReader { geometry in
            ZoomableView(size: CGSize(width: geometry.size.width, height: geometry.size.height), min: 1.0, max: 6.0, showsIndicators: true) {
                StickyContentView()
            }
            .ignoresSafeArea()
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

