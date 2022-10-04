
//  Home.swift
//  MetaBall
//
//  Created by HIROKI IKEUCHI on 2022/10/04.
//

import SwiftUI

struct Home: View {
    
    // MARK: Animation Properties
    
    @State private var dragOffset: CGSize = .zero
    @State private var startAnimation: Bool = false
    @State private var type: String = "Single"
    
    var body: some View {
        VStack {
            
            Text("Metaball Animation")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(15)
            
            Picker(selection: $type) {
                Text("Metaball")
                    .tag("Single")
                Text("Clubbed")
                    .tag("Clubbed")
            } label: {
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 15)
            
            if type == "Single" {
                SingleMetaBall()
            } else {
                ClubbedView()
            }
        }
    }
    
    // MARK: Clubbed One
    // Like Blob background animation
    @ViewBuilder
    private func ClubbedView() -> some View {
        
        Rectangle()
            .fill(.linearGradient(colors: [Color("Gradient1"), Color("Gradient2")],
                                  startPoint: .top,
                                  endPoint: .bottom))
            .mask {
                // It's quite the same with the addition of TimelineView
                // MARK: Timing is your wish for how long the animation needs to be changed
                TimelineView(.animation(minimumInterval: 3.6, paused: false)) { _ in
                    Canvas { context, size in
                        context.addFilter(.alphaThreshold(min: 0.5, color: .white))
                        context.addFilter(.blur(radius: 30))
                        
                        // MARK: Drawing Layer
                        context.drawLayer { ctx in
                            // MARK: Placing symbols
                            for index in 1...15 {
                                if let resolvedView = context.resolveSymbol(id: index) {
                                    ctx.draw(resolvedView, at: CGPoint(x: size.width / 2,
                                                                       y: size.height / 2))
                                }
                            }
                        }
                    } symbols: {
                        // MARK: Count is your wish
                        ForEach(1...15, id: \.self) { index in
                            // MARK: Generating custom offset for each time
                            // Thus it will be at random places and clubbed with each other
                            let offset = startAnimation ?
                            CGSize(width: .random(in: -180...180), height: .random(in: -240...240)) :
                                .zero
                            ClubbedRoundedRectangle(offset: offset)
                                .tag(index)
                        }
                    }
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                startAnimation.toggle()
            }
    }
    
    @ViewBuilder
    private func ClubbedRoundedRectangle(offset: CGSize) -> some View {
        RoundedRectangle(cornerRadius: 30, style: .continuous)
            .fill(.white)
            .frame(width: 120, height: 120)
            .offset(offset)
        // MARK: Adding animation
        // less than TimelineView refresh rate
            .animation(.easeInOut(duration: 4), value: offset)
    }
    
    // MARK: Single MetaBall Animation
    @ViewBuilder
    private func SingleMetaBall() -> some View {
        
        Rectangle()
            .fill(.linearGradient(colors: [Color("Gradient1"), Color("Gradient2")],
                                  startPoint: .top,
                                  endPoint: .bottom))
            .mask {
                Canvas { context, size in
                    context.addFilter(.alphaThreshold(min: 0.5, color: .white))
                    context.addFilter(.blur(radius: 30))
                    
                    // MARK: Drawing Layer
                    context.drawLayer { ctx in
                        // MARK: Placing symbols
                        for index in [1, 2] {
                            if let resolvedView = context.resolveSymbol(id: index) {
                                ctx.draw(resolvedView, at: CGPoint(x: size.width / 2,
                                                                   y: size.height / 2))
                            }
                        }
                    }
                } symbols: {
                    Ball()
                        .tag(1)
                    Ball(offset: dragOffset)
                        .tag(2)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        dragOffset = value.translation
                    })
                    .onEnded({ _ in
                        withAnimation(
                            .interactiveSpring(response: 0.6,
                                               dampingFraction: 0.7,
                                               blendDuration: 0.7)
                        ) {
                            dragOffset = .zero
                        }
                    })
            )
    }
    
    @ViewBuilder
    private func Ball(offset: CGSize = .zero) -> some View {
        Circle()
            .fill(.white)
            .frame(width: 150, height: 150)
            .offset(offset)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
