import SwiftUI

struct ContentView: View {
    
    @StateObject private var stickyList = StickyList()
    @State private var center: CGPoint = .init(x: 200, y: 200)  // 初期位置
    @State private var distanceFromCenter: CGPoint = .zero  // オブジェクトの中心とタッチ地点との距離
    
    @State private var draggingFromDeckPosition: CGPoint = .zero
    @State private var isDraggingFromDeck = false
    
    var body: some View{
        ZStack {
            stickyCanvas()
            customToolbar()
        }
        .background(.blue.opacity(0.1))
    }
    
    private func addRandomSticky() {
        stickyList.add(sticky:
                .init(message: "ふせんだよふせんだよ\nふせんだよふせんだよ\nふせんだよふせんだよ",
                      positon: .init(x: Int.random(in: 150...300), y: Int.random(in: 0...400))))
    }
    
    // MARK: - ViewBuilder
    
    @ViewBuilder
    private func customToolbar() -> some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.accentColor, lineWidth: 4)
                    .frame(height: 80)
                    .background(Color.secondary.opacity(0.1).cornerRadius(10))
                HStack {
                    StickyDeck()
                        .frame(width: 100, height: 50)
                        .padding(.leading, 20)
                        .gesture(
                            DragGesture(coordinateSpace: .global)
                                .onChanged({ value in
                                    print(value.startLocation)
                                    isDraggingFromDeck = true
                                    if distanceFromCenter == .zero {
                                        isDraggingFromDeck = true
                                        distanceFromCenter = CGPoint(x: -50, y: 50)
                                    } else {
                                        draggingFromDeckPosition =
                                        CGPoint(x: value.startLocation.x + value.translation.width - distanceFromCenter.x,
                                                y: value.startLocation.y + value.translation.height - distanceFromCenter.y)
                                    }
                                })
                                .onEnded({ value in
                                    isDraggingFromDeck = false
                                    draggingFromDeckPosition = .zero
                                    distanceFromCenter = .zero
                                    print(draggingFromDeckPosition)
                                })
                        )
                    Spacer()
                    Button {
                        addRandomSticky()
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                    .padding(.trailing, 20)
                }
            }
        }
        .frame(height: 80)
        .padding()
    }
    
    @ViewBuilder
    private func stickyCanvas() -> some View {
        GeometryReader { geometry in
            
            if isDraggingFromDeck {
                Rectangle()
                    .frame(width: 100, height: 100)
                    .position(draggingFromDeckPosition)
            }
            
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

