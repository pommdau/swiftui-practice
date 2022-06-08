//
//  SwipeToDismissModifier.swift
//  TransitionDemo
//
//  Created by HIROKI IKEUCHI on 2022/06/03.
//

import Foundation
import SwiftUI

struct SwipeToDismissModifier: ViewModifier {
    
    let dismissThreshold: CGFloat = 150
    
    var swiping: (Float) -> Void
    var onDismissToTop: () -> Void
    var onDismissToBottom: () -> Void
    var cancelSwiping: () -> Void
    
    @State private var offset: CGSize = .zero
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
                .offset(y: offset.height)
                .animation(.interactiveSpring(), value: offset)
                .simultaneousGesture(
                    DragGesture()
                        .onChanged { gesture in
                            if gesture.translation.width < 50 {
                                offset = gesture.translation
                            }
                            let progress = abs(Float(offset.height / geometry.size.height))  // 画面の高さに対してどれだけスワイプされているかの比率
                            swiping(progress)
                        }
                        .onEnded { _ in
                            if offset.height < -dismissThreshold {
                                onDismissToTop()
                            } else if offset.height > dismissThreshold {                                
                                onDismissToBottom()
                            } else {
                                offset = .zero
                                cancelSwiping()
                            }
                        }
                )
        }

    }
}
