import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var stickyList = StickyList()
    
    var body: some View{
        GeometryReader { geometry in            
            ForEach(stickyList.stickies.indices, id: \.self) { index in
                Pages(currentPage: $stickyList.stickies[index].currentPageIndex,
                      transitionStyle: .pageCurl,
                      hasControl: false, onDelete: {
                    stickyList.stickies.remove(at: index)
                }) {
                    StickyView(sticky: stickyList.stickies[index])
                    Rectangle()
                        .foregroundColor(Color.black.opacity(0.01))
                }
                .frame(width: 300, height: 200)
                .offset(x: stickyList.stickies[index].positon.x, y: stickyList.stickies[index].positon.y)
                
//                .onChange(of: stickyList.stickies[index].currentPageIndex) { newValue in
//                    print(index)
//                    stickyList.remove(sticky: stickyList.stickies[index])
//                }
            }
            .onDelete { index in
                print("🐱 \(index)")
            }
        }
        .background(.red.opacity(0.1))
//        .onChange(of: stickyList.stickies) { newValue in
//            print(index)
//            stickyList.remove(sticky: stickyList.stickies[index])
//        }
        .onAppear {
            stickyList.add(sticky: .init(message: "HogeHoge", positon: .init(x: 0, y: 100)))
            stickyList.add(sticky: .init(message: "HogeHoge", positon: .init(x: 10, y: 200)))
            stickyList.add(sticky: .init(message: "HogeHoge", positon: .init(x: 0, y: 300)))
        }
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

