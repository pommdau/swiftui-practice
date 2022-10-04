//
//  MorphingView.swift
//  Morphing
//
//  Created by HIROKI IKEUCHI on 2022/10/04.
//

import SwiftUI

struct MorphingView: View {
    
    @State private var currentImage: CustomShape = .cloud
    @State private var pickerImage: CustomShape = .cloud
    @State private var turnOffImageMorph: Bool = false
    @State private var blurRadius: CGFloat = 0
    @State private var animateMorph: Bool = false

    var body: some View {
        VStack {
            
            // Morph is simple
            // Simply Mask the canvas sha;e as image mask
            GeometryReader { proxy in
                let size = proxy.size
                Image("iJustine")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(x: -20, y: 40)
                    .frame(width: size.width, height: size.height)
                    .clipped()
                    .overlay(content: {
                        Rectangle()
                            .fill(.white)
                            .opacity(turnOffImageMorph ? 1 : 0)
                    })
                    .mask {
                        // MARK: Morphing shapes with the help of Canvas and Filters
                        Canvas { context, size in
                            // MARK: Morphing filters
                            // for more Morph shape link, change this value
                            context.addFilter(.alphaThreshold(min: 0.5))
                            // MARK: This value plays major role in the morphing animation
                            // MARK: For reverse animation
                            // until 20 -> It will be like 0-1
                            // after 20 till 40 -> It will be like 1-0
                            context.addFilter(.blur(radius: blurRadius >= 20 ?
                                                    40 - blurRadius :
                                                        blurRadius
                                                   ))
                            
                            // MARK: Draw inside layer
                            context.drawLayer { ctx in
                                if let resolvedImage = context.resolveSymbol(id: 1) {
                                    ctx.draw(resolvedImage,
                                             at: CGPoint(x: size.width / 2, y: size.height / 2),
                                             anchor: .center)
                                }
                            }
                        } symbols: {
                            // MARK: Giving images with ID
                            ResolvedImage(currentImage: $currentImage)
                                .tag(1)
                        }
                        // MARK: Animation wil lnot work in the Canvas
                        // We can use TimelineView for the animations
                        // But here I'm going to simply use timer to acheive the same effect
                        .onReceive(Timer.publish(every: 0.007, on: .main, in: .common).autoconnect()) { _ in
                            if animateMorph {
                                if blurRadius <= 40 {
                                    // this is animation speed
                                    // you can change this for your own
                                    blurRadius += 0.5
                                    
                                    if blurRadius.rounded() == 20 {
                                        // MARK: Change of next image goes here
                                        currentImage = pickerImage
                                    }
                                }
                                
                                if blurRadius.rounded() == 40 {
                                    // MARK: end animation and reset the blur radius to zero
                                    animateMorph = false
                                    blurRadius = 0
                                }
                            }
                        }
                    }
            }
            .frame(height: 400)
            
            Picker("", selection: $pickerImage) {
                ForEach(CustomShape.allCases, id: \.rawValue) { shape in
                    Image(systemName: shape.rawValue)
                        .tag(shape)
                }
            }
            .pickerStyle(.segmented)
            // MARK: Avoid tap until the current animation is finished
            .overlay(content: {
                Rectangle()
                    .fill(.primary)
                    .opacity(animateMorph ? 0.05 : 0)
            })
            .padding(15)
            .padding(.top, -50)
            // MARK: When ever picker image changes
            // Morphing into new shape
            .onChange(of: pickerImage) { newValue in
                animateMorph = true
            }
                        
            Toggle("Turn Off Image Morph", isOn: $turnOffImageMorph)
                .fontWeight(.semibold)
                .padding(.horizontal, 15)
                .padding(.top, 10)
            
            Slider(value: $blurRadius, in: 0...40)
        }
        .offset(y: -50)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct ResolvedImage: View {
    @Binding var currentImage: CustomShape
    
    var body: some View {
        Image(systemName: currentImage.rawValue)
            .font(.system(size: 200))
            .animation(.interactiveSpring(response: 0.7,
                                          dampingFraction: 0.8,
                                          blendDuration: 0.8),
                       value: currentImage)
            .frame(width: 300, height: 300)
    }
}

struct MorphingView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
