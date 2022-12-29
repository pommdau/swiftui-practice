import SwiftUI

struct ContentView: View {
    var body: some View{
        TabView{
            Text("チュートリアル1")
                .frame(width: UIScreen.main.bounds.size.width, height: 500)
                .background(Color(red: 0.8, green: 0.8, blue: 0.8))
                .tag(0)
            Text("チュートリアル2")
                .frame(width: UIScreen.main.bounds.size.width, height: 500)
                .background(Color(red: 0.6, green: 0.99, blue: 0.6))
                .tag(1)
            Text("チュートリアル3")
                .frame(width: UIScreen.main.bounds.size.width, height: 500)
                .background(Color(red: 1, green: 0.75, blue: 0.78))
                .tag(2)
        }
        .tabViewStyle(PageTabViewStyle())
//        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

