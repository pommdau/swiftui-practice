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
    
    var backgroundColor: Color = .black
    
    func body(content: Content) -> some View {
        ZStack {
            if showingModal {
                // 画像周りの背景色
                backgroundColor
                    .ignoresSafeArea()
                    .opacity(backgroundColorOpacity)
                    .transition(.opacity)
            }
            
            if showingModal {
                content
                    .modifier(SwipableModifier(
                        backgroundColorOpacity: $backgroundColorOpacity,
                        imageDismissTransition: $imageDismissTransition,
                        onDismiss: {
                            withAnimation {
                                showingModal = false
                            }
                        }))
                    .zIndex(1)
                    .transition(.asymmetric(insertion: .opacity,
                                            removal: imageDismissTransition))
            }
        }
    }
}

struct SwipableModifier: ViewModifier {
    
    // MARK: - Properties
    
    @Binding var backgroundColorOpacity: Double
    @Binding var imageDismissTransition: AnyTransition
    var onDismiss: () -> Void
    
    @State private var offset: CGSize = .zero
    private let dismissThreshold: CGFloat = 150
    
    // MARK: - View
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                Color.clear
                    .contentShape(Rectangle())
                    .ignoresSafeArea()
                content
                    .offset(y: offset.height)
                    .animation(.interactiveSpring(), value: offset)
            }
            .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
            .simultaneousGesture(
                swipeGesture(geometry: geometry)
            )
        }
    }
    
    // MARK: - Helpers
    
    private func swipeGesture(geometry: GeometryProxy) -> some Gesture {
        DragGesture()
            .onChanged { gesture in
                if gesture.translation.width < 50 {
                    offset = gesture.translation
                }
                // 画面の高さに対してどれだけスワイプされているかの比率
                backgroundColorOpacity = 1 - abs(Double(offset.height / geometry.size.height))
            }
            .onEnded { _ in
                if offset.height < -dismissThreshold {
                    imageDismissTransition = .move(edge: .top)
                    onDismiss()
                    backgroundColorOpacity = 1.0
                } else if offset.height > dismissThreshold {
                    imageDismissTransition = .move(edge: .bottom)
                    onDismiss()
                    backgroundColorOpacity = 1.0
                } else {
                    offset = .zero
                    backgroundColorOpacity = 1.0
                }
            }
    }
    
}
