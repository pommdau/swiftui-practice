//
//  LoopingStack.swift
//  LoopingCards
//
//  Created by HIROKI IKEUCHI on 2026/01/06.
//

import SwiftUI

struct LoopingStack<Content: View>: View {
    
    var visibleCardsCount: Int = 2
    @ViewBuilder var content: Content
    
    @State private var offset: CGFloat = .zero
    
    var body: some View {
        Group(subviews: content) { collection in
            let count = collection.count
            ZStack {
                ForEach(collection) { view in
                    let index = collection.index(view)
                    let zIndex = Double(count - index) // 0枚目が一番上
                    // 指定した枚数分だけ下に表示する
                    let offsetConst: Double = 40
                    let extraOffset = min(CGFloat(index) * offsetConst, CGFloat(visibleCardsCount) * offsetConst)
                    let scaleConst = 0.07
                    let scale = 1 - min(CGFloat(index) * scaleConst, CGFloat(visibleCardsCount) * scaleConst)
                    view
                        .offset(x: extraOffset)
                        .scaleEffect(scale)
                        .offset(x: offset)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let xOffset = -max(-value.translation.width, 0) // 左方向のみドラッグ可能
                                    offset = xOffset
                                }
                                .onEnded { value in
                                    let xVelocity = max(-value.velocity.width / 5, 0)
                                    withAnimation(.smooth(duration: 0.3, extraBounce: 0)) {
                                        offset = .zero
                                    }
                                }
                            
                        )
                        .zIndex(zIndex)
                }
            }
        }
    }
}

extension SubviewsCollection {
    func index(_ item: SubviewsCollection.Element) -> Int {
        firstIndex(where: { $0.id == item.id }) ?? 0
    }
}

#Preview {
    ContentView()
}

