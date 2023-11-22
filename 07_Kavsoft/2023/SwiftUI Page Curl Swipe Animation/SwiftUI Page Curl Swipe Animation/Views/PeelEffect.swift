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
    @State private var isExpanded: Bool = false
    
    var body: some View {
        content
            .hidden()
            .overlay {
                GeometryReader {
                    let rect = $0.frame(in: .global)
                    let minX = rect.minX
                    
                    /// Replace it as Background View
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(.red.gradient)
                        .overlay(alignment: .trailing) {
                            Button {
                                /// Removing card completely
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                    dragProgress = 1
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                                    onDelete()
                                }
                            } label: {
                                Image(systemName: "trash")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .padding(.trailing, 20)
                                    .foregroundColor(.white)
                            }
                            .disabled(!isExpanded)
                        }
                        .padding(.vertical, 8)
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    /// Disabling gesture whtn it's expanded
                                    guard !isExpanded else { return }
                                    /// Right to Left Swipe: Negative Value
                                    var translationX = value.translation.width
                                    /// Limiting to Max Zero
                                    translationX = max(-translationX, 0)
                                    /// Converting Translation Into Progress (0 - 1)
                                    let progress = min(1, translationX / rect.width)
                                    dragProgress = progress
                                })
                                .onEnded({ value in
                                    /// Disabling gesture whtn it's expanded
                                    guard !isExpanded else { return }
                                    /// Smooth ending animation
                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                        if dragProgress > 0.25 {
                                            dragProgress = 0.6
                                            isExpanded = true
                                        } else {
                                            dragProgress = .zero
                                            isExpanded = false
                                        }
                                    }
                                })
                        )
                    
                    /// If we tap other than delete button, it will reset to initial state
                        .onTapGesture {
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                dragProgress = .zero
                                isExpanded = false
                            }
                        }
                    
                    /// Background Shadow
                    Rectangle()
                        .fill(.black)
                        .padding(.vertical, 23)
                        .shadow(color: .black.opacity(0.3), radius: 15, x: 30, y: 0)
                        .padding(.trailing, rect.width * dragProgress)
                        .mask(content)
                    /// Disabling Interaction
                        .allowsHitTesting(false)
                        .offset(x: dragProgress == 1 ? -minX : 0)
                    
                    content
                        .mask {
                            /// Masking Original Content
                            Rectangle()
                            /// Swipe: Right to Left
                            /// Thus Masking from right to left (trailing)
                                .padding(.trailing, dragProgress * rect.width)
                        }
                    /// Disable interaction
                        .allowsHitTesting(false)
                        .offset(x: dragProgress == 1 ? -minX : 0)
                }
            }
            .overlay {
                GeometryReader {
                    let size = $0.size
                    let minX = $0.frame(in: .global).minX
                    let minOpacity = dragProgress / 0.05
                    let opacity = min(1, minOpacity)
                    
                    content
                    /// Making it look like it's rolling
                        .shadow(color: .black.opacity(dragProgress != 0 ? 0.1 : 0), radius: 5, x: 15, y: 0)
                        .overlay {
                            Rectangle()
                                .fill(.white.opacity(0.25))
                                .mask(content)
                        }
                    
                    /// Making it Glow at the back side
                        .overlay(alignment: .trailing) {
                            Rectangle()
                                .fill(
                                    .linearGradient(
                                        colors: [
                                            .clear,
                                            .white,
                                            .clear,
                                            .clear
                                        ],
                                        startPoint: .leading,
                                        endPoint: .trailing)
                                )
                                .frame(width: 60)
                                .offset(x: 40)
                                .offset(x: -30 + (30 * opacity))
                                .offset(x: size.width * -dragProgress)
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
                        .offset(x: dragProgress == 1 ? -minX : 0)
                }
                /// Disable interaction
                    .allowsHitTesting(false)
            }
    }
}

#Preview {
    ContentView()
}
