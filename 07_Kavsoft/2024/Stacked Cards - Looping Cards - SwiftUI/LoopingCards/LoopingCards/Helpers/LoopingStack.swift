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
                    
                    LoopingStackCardView(
                        index: index,
                        count: count,
                        visibleCardsCount: visibleCardsCount) {
                            view
                        }
                        .zIndex(zIndex)
                }
            }
        }
    }
}

fileprivate struct LoopingStackCardView<Content: View>: View {
    
    var index: Int
    var count: Int
    var visibleCardsCount: Int
    
    @ViewBuilder var content: Content
    @State private var offset: CGFloat = .zero
    @State private var viewSize: CGSize = .zero
    
    var body: some View {
        
        // 指定した枚数分だけ下に表示する
        let offsetConst: Double = 40
        let extraOffset = min(CGFloat(index) * offsetConst, CGFloat(visibleCardsCount) * offsetConst)
        let scaleConst = 0.07
        let scale = 1 - min(CGFloat(index) * scaleConst, CGFloat(visibleCardsCount) * scaleConst)
        
        let rotationDegree: CGFloat = -30
        let rotation = max(min(-offset / viewSize.width, 1), 0) * rotationDegree
        
        content
            .onGeometryChange(
                for: CGSize.self,
                of: { $0.size },
                action: { viewSize = $0 }
            )
            .offset(x: extraOffset)
            .scaleEffect(scale)
            .offset(x: offset)
            .rotation3DEffect(
                Angle(degrees: rotation),
                axis: (0, 1, 0),
                anchor: .center,
                perspective: 0.5
            )
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let xOffset = -max(-value.translation.width, 0) // 左方向のみドラッグ可能
                        offset = xOffset
                    }
                    .onEnded { value in
                        let xVelocity = max(-value.velocity.width / 5, 0)
                        
                        if (-offset + xVelocity) > (viewSize.width * 0.65) {
                            pushToNextCard()
                        } else {
                            withAnimation(.smooth(duration: 0.3, extraBounce: 0)) {
                                offset = .zero
                            }
                        }
                    },
                isEnabled: index == 0 // 一番上のみジェスチャーが有効
                
            )
    }
    
    private func pushToNextCard() {
        let animation: Animation = .smooth(duration: 0.25, extraBounce: 0).logicallyComplete(after: 0.15)
       
        withAnimation(animation, completionCriteria: .logicallyComplete) {
            offset = -viewSize.width
        } completion: {
            withAnimation(.smooth(duration: 0.25, extraBounce: 0)) {
                offset = .zero
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

