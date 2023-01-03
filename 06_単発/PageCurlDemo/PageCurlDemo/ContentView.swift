import SwiftUI

struct ContentView: View {
    
    @StateObject private var stickyList = StickyList()
    @State private var center: CGPoint = .init(x: 200, y: 200)  // 初期位置
    @State private var distanceFromCenter: CGPoint = .zero  // オブジェクトの中心とタッチ地点との距離
    
    var body: some View{
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
                    ZStack {
                        Pages(currentPage: $stickyList.stickies[index].currentPageIndex,
                              transitionStyle: .pageCurl,
                              hasControl: false, onDelete: {
                            stickyList.stickies.remove(at: index)
                        }) {
                            StickyView(sticky: $stickyList.stickies[index])
                            Rectangle()
                                .foregroundColor(Color.black.opacity(0.01))
                        }
                        Color.clear
                            .contentShape(Rectangle())
                            .frame(width: 40)
                            .offset(x: -130)
                            .gesture(
                                DragGesture(coordinateSpace: .global)                                
                                    .onChanged({ value in
                                        print(value)
                                        if distanceFromCenter == .zero {
                                            distanceFromCenter = CGPoint(x: value.startLocation.x - stickyList.stickies[index].positon.x,
                                                                         y: value.startLocation.y - stickyList.stickies[index].positon.y)
                                        } else {
                                            stickyList.stickies[index].positon = CGPoint(x: value.startLocation.x + value.translation.width - distanceFromCenter.x,
                                                             y: value.startLocation.y + value.translation.height - distanceFromCenter.y)
                                        }
                                    })
                                    .onEnded({ value in
                                        distanceFromCenter = .zero
                                    })
                            )
                    }
                    .frame(width: 300, height: 200)
                    .position(stickyList.stickies[index].positon)
                }
            }
            .background(.red.opacity(0.1))
            .onAppear {
                for _ in 0...1 {
                    addRandomSticky()
                }
            }
        }
    }
    
    private func addRandomSticky() {
        stickyList.add(sticky:
                .init(message: "ふせんだよふせんだよ\nふせんだよふせんだよ\nふせんだよふせんだよ",
                      positon: .init(x: Int.random(in: 150...300), y: Int.random(in: 0...400))))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

