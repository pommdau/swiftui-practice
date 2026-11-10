//
//  LoopingStackPokepoke.swift
//  LoopingCards
//
//  Created by HIROKI IKEUCHI on 2026/01/07.
//

import SwiftUI

struct LoopingStackPokepoke<Content: View>: View {
    
    var visibleCardsCount: Int = 2
    var maxTranslationWidth: CGFloat?
    @ViewBuilder var content: Content
    @State private var offset: CGFloat = .zero
    @State private var rotation: Int = 0
    @State private var dragProgress: CGFloat = .zero // ドラッグ割合
    
    var body: some View {
        Group(subviews: content) { collection in
            let collection = collection.rotateFromLeft(by: rotation)
            let count = collection.count
            ZStack {
                ForEach(collection) { view in
                    let index = collection.index(view)
                    let zIndex = Double(count - index) // 0枚目が一番上
                    LoopingStackCardViewPokepoke(
                        index: index,
                        count: count,
                        visibleCardsCount: visibleCardsCount,
                        maxTranslationWidth: maxTranslationWidth,
                        rotation: $rotation,
                        dragProgress: $dragProgress
                    ) {
                            view
                        }
                        .zIndex(zIndex)
                }
            }
        }
//        .gesture(
//            DragGesture()
//                .onChanged { value in
//                    let maxOffset: Double = 30
//                    // -maxOffset ~ maxOffset
//                    offset = min(maxOffset, max(-maxOffset, value.translation.width))
//                }
//                .onEnded { value in
////                    let xVelocity = max(-value.velocity.width / 5, 0)
////                    
////                    if (-offset + xVelocity) > (viewSize.width * 0.65) {
////                        pushToNextCard()
////                    } else {
////                        withAnimation(.smooth(duration: 0.3, extraBounce: 0)) {
////                            offset = .zero
////                        }
////                    }
//                }
//        )
    }
}

fileprivate struct LoopingStackCardViewPokepoke<Content: View>: View {
    
    var index: Int
    var count: Int
    var visibleCardsCount: Int
    var maxTranslationWidth: CGFloat?
    
    @Binding var rotation: Int
    @Binding var dragProgress: CGFloat
    @ViewBuilder var content: Content
    @State private var offset: CGFloat = .zero
    @State private var viewSize: CGSize = .zero
    
    var body: some View {
        
        // 指定した枚数分だけ下に表示する
        let offsetConst: Double = 40
        let extraOffset = min(CGFloat(index) * offsetConst, CGFloat(visibleCardsCount) * offsetConst)
        let scaleConst = 0.02
        let scale = 1 - CGFloat(index) * scaleConst
        
        let rotationDegree: CGFloat = -36
//        let rotation = max(min(-dragProgress * 60 / viewSize.width, 1), 0) * rotationDegree
        let rotation = rotationDegree * dragProgress
        
        content
            .onGeometryChange(
                for: CGSize.self,
                of: { $0.size },
                action: { viewSize = $0 }
            )
            .scaleEffect(scale)
            .animation(.smooth(duration: 0.25, extraBounce: 0), value: index)
            .offset(x: dragProgress * CGFloat(10 * index))
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
                        let maxOffset: Double = 100
                        // -maxOffset ~ maxOffset
                        let newOffset = min(maxOffset, max(-maxOffset, value.translation.width))
                        dragProgress = newOffset / maxOffset // 割合
                        print(dragProgress)
                    }
                    .onEnded { value in
                        withAnimation(.smooth(duration: 0.3, extraBounce: 0)) {
                            dragProgress = .zero
                        }
                    },
                isEnabled: index == 0 && count > 1 // 一番上のみジェスチャーが有効
            )
            .onTapGesture {
                pushToNextCard()
            }
    }
    
    private func pushToNextCard() {
        let animation: Animation = .smooth(duration: 0.25, extraBounce: 0).logicallyComplete(after: 0.15)
       
        withAnimation(animation, completionCriteria: .logicallyComplete) {
            offset = -viewSize.width * 1.1
        } completion: {
            rotation += 1
            withAnimation(.smooth(duration: 0.40, extraBounce: .zero)) {
                offset = .zero
            }
        }
    }
}

#Preview {
    ContentView()
}

