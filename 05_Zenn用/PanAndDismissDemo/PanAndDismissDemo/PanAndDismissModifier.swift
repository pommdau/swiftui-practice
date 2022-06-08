//
//  PanAndDismissModifier.swift
//  PanAndDismissDemo
//
//  Created by HIROKI IKEUCHI on 2022/06/08.
//

import Foundation
import SwiftUI

struct PanAndDismissModifier: ViewModifier {
    
    @Binding var showingModal: Bool
    @State private var imageDismissTransition: AnyTransition = .move(edge: .leading)
    @State private var backgroundColorOpacity: Double = 1.0
        
    func body(content: Content) -> some View {
        ZStack {
            if showingModal {
                // 画像周りの背景色
                Color(.black)
                    .ignoresSafeArea()
                    .opacity(backgroundColorOpacity)
                    .transition(.opacity)
            }
            
            if showingModal {
                content
//                SwipableImageView(imageName: imageName,
//                                  backgroundColorOpacity: $backgroundColorOpacity,
//                                  imageDismissTransition: $imageDismissTransition,
//                                  onDismiss: {
//                    withAnimation {
//                        showingModal = false
//                    }
//                })
                .zIndex(1)
                .transition(.asymmetric(insertion: .opacity,
                                        removal: imageDismissTransition))
            }
        }
    }
}

struct SwipableModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        
    }
    
}
