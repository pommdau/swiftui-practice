import SwiftUI

struct ContentView: View {
    
    @StateObject private var stickyList = StickyList()
    
    var body: some View{
//        StickyView(sticky: sticky)
//            .frame(width: 300, height: 200)
//            .gesture(
//                DragGesture()
//                    .onChanged{ value in
//                        sticky.positon = value.location
//                    }
//                    .onEnded{ value in
//                        sticky.positon = value.location
//                    }
//            )
//            .position(sticky.positon)
        
        VStack {
            HStack {
                Spacer()
                Button {
                    addRandomSticky()
                } label: {
                    Image(systemName: "plus.circle")
                }
                .padding(.trailing, 20)
            }

            GeometryReader { geometry in
                ForEach(stickyList.stickies.indices, id: \.self) { index in
                    Pages(currentPage: $stickyList.stickies[index].currentPageIndex,
                          transitionStyle: .pageCurl,
                          hasControl: false, onDelete: {
                        stickyList.stickies.remove(at: index)
                    }) {
                        StickyView(sticky: $stickyList.stickies[index])
                        Rectangle()
                            .foregroundColor(Color.black.opacity(0.01))
                    }
                    .frame(width: 300, height: 200)
                    .position(x: stickyList.stickies[index].positon.x + 200,
                              y: stickyList.stickies[index].positon.y)
                }
            }
            .background(.red.opacity(0.1))
            .onAppear {
                for _ in 0...3 {
                    addRandomSticky()
                }
            }
        }
    }
    
    private func addRandomSticky() {
        stickyList.add(sticky:
                .init(message: "HogeHoge",
                      positon: .init(x: Int.random(in: 0...30), y: Int.random(in: 0...400))))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

