import SwiftUI

struct ContentView: View {
    var body: some View{
        
        VStack {
            StickyView(darkColor: .stickyDarkOrange, lightColor: .stickyLightOrange)
                .frame(width: 200, height: 100)
            StickyView(darkColor: .stickyDarkGreen, lightColor: .stickyLightGreen)
                .frame(width: 200, height: 100)
            StickyView(darkColor: .stickyDarkYellow, lightColor: .stickyLightYellow)
                .frame(width: 200, height: 100)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

