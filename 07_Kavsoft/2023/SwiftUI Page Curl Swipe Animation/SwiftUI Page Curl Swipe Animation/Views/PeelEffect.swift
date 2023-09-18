//
//  PeelEffect.swift
//  SwiftUI Page Curl Swipe Animation
//
//  Created by HIROKI IKEUCHI on 2023/09/18.
//

import SwiftUI

/// Custom View Builder
struct PeelEffect<Content: View>: View {
    
    var content: Content
    /// Delete Callback for MainView, When Delete is Clicked
    var onDelete: () -> ()
    
    init(@ViewBuilder content: @escaping () -> Content,
         onDelete: @escaping () -> ()) {
        self.content = content()
        self.onDelete = onDelete
    }
    
    @State private var dragProgress: CGFloat = 0
    
    var body: some View {
        content
            /// Masking Original Content
            .mask {
                GeometryReader {
                    let rect = $0.frame(in: .global)
                    Rectangle()
                        .padding(.trailing, dragProgress * rect.width)
                }
            }                
            .overlay {
                GeometryReader {
                    let rect = $0.frame(in: .global)
                    let size = $0.size
                    
                    content
                    /// Making it look like it's rolling
                        .shadow(color: .black.opacity(dragProgress != 0 ? 0.1 : 0), radius: 5, x: 15, y: 0)
                        .overlay {
                            Rectangle()
                                .fill(.white.opacity(0.25))
                                .mask(content)
                        }
                    
                    /// Flipping Horizontally for upsize down
                        .scaleEffect(x: -1)
                    /// Moving Along Side While Dragging
                        .offset(x: size.width - (size.width * dragProgress))
                        .offset(x: size.width * -dragProgress)
                    /// Masking Overlayed Image For Removing Outbound Visbillyty
                        .mask {
                            Rectangle()
                                .offset(x: size.width * -dragProgress)
                        }
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    /// Right to Left Swipe: Negative Value
                                    var translationX = value.translation.width
                                    /// Limiting to Max Zero
                                    translationX = max(-translationX, 0)
                                    /// Converting Translation Into Progress (0 - 1)
                                    let progress = min(1, translationX / size.width)
                                    dragProgress = progress
                                })
                                .onEnded({ value in
                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                        dragProgress = .zero
                                    }
                                })
                        )
                }
            }
            .background {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(.red.gradient)
                    .overlay(alignment: .trailing) {
                        Image(systemName: "trash")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.trailing, 20)
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 8)
            }
    }
}

#Preview {
    ContentView()
}
