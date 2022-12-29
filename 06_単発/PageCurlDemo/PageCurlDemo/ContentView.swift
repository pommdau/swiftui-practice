import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var stickyList = StickyList()
    
    var body: some View{
        
        VStack {
            HStack {
                Spacer()
                Button {
                    addRandomSticky()
                } label: {
                    Image(systemName: "plus.circle")
                }
                .padding(.leading, 20)
            }
            
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

