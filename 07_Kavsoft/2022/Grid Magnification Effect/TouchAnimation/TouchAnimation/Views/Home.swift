//
//  Home.swift
//  TouchAnimation
//
//  Created by HIROKI IKEUCHI on 2022/08/15.
//

import SwiftUI

struct Home: View {
    
    @Binding var animationEffect: AnimationEffect
    
    // MARK: Gesture State
    @GestureState var location: CGPoint = .zero
        
    var body: some View {
        switch animationEffect {
        case .one:
            View1()
        case .two:
            Text("two")
        case .three:
            View3()
        }
    }
    
    @ViewBuilder
    private func View3() -> some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            //  MARK: To Fit Into Whole View
            // Calculating Item Count with the help of Height & Width
            // In a Row We Have 10 Items
            let width = (size.width / 10)
            
            // Multiplying Each Row Count
            let itemCount = Int((size.height / width).rounded()) * 10
            
            // MARK: For solid linear gradient
            // we're going to use mask
            LinearGradient(colors: [.cyan, .yellow, .mint, .pink, .purple],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .mask {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0),
                                         count: 10),
                          spacing: 0) {
                    ForEach(0..<itemCount, id: \.self) { _ in
                        GeometryReader { innerProxy in
                            let rect = innerProxy.frame(in: .named("GESTURE"))
                            let scale = itemScale(rect: rect, size: size)
                            
                            RoundedRectangle(cornerRadius: 4)
                                .fill(.orange)
                                .scaleEffect(scale)
                        }
                        .padding(5)
                        .frame(height: width)
                    }
                }
            }
        }
        .padding(15)
        .gesture(
            DragGesture(minimumDistance: 0)
                .updating($location, body: { value, out, _ in
                    out = value.location
                })
        )
        .coordinateSpace(name: "GESTURE")
        .preferredColorScheme(.dark)
        .animation(.easeInOut, value: location == .zero)
    }
    
    @ViewBuilder
    private func View1() -> some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            //  MARK: To Fit Into Whole View
            // Calculating Item Count with the help of Height & Width
            // In a Row We Have 10 Items
            let width = (size.width / 10)
            
            // Multiplying Each Row Count
            let itemCount = Int((size.height / width).rounded()) * 10
            
            // MARK: For solid linear gradient
            // we're going to use mask
            LinearGradient(colors: [.cyan, .yellow, .mint, .pink, .purple],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .mask {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 10),
                          spacing: 0) {
                    ForEach(0..<itemCount, id: \.self) { _ in
                        GeometryReader { innerProxy in
                            let rect = innerProxy.frame(in: .named("GESTURE"))
                            let scale = itemScale(rect: rect, size: size)
                            
                            // MARK: Instead of manual caluculation,
                            // we're going to use UIKit's CGAffineTransform
                            let transformedRect = rect.applying(
                                .init(scaleX: scale, y: scale)
                            )
                            
                            // MARK: Transforming location too
                            let transformedLocation = location.applying(
                                .init(scaleX: scale, y: scale)
                            )
                            
                            RoundedRectangle(cornerRadius: 4)
                                .fill(.orange)
                                .scaleEffect(scale)
                            
                            // MARK: For Effect 1
                            // We Need to Re-Locate Every Item To Currently Draaging Postion
                                .offset(x: (transformedRect.midX - rect.midX),
                                        y: (transformedRect.midY - rect.midY))
                                .offset(x: (location.x - transformedLocation.x),
                                        y: (location.y - transformedLocation.y))
                            
                            // MARK: For effect2 simply replace scale location
//                                .scaleEffect(scale)
                            
                        }
                        .padding(5)
                        .frame(height: width)
                    }
                }
            }
        }
        .padding(15)
        .gesture(
            DragGesture(minimumDistance: 0)
                .updating($location, body: { value, out, _ in
                    out = value.location
                })
        )
        .coordinateSpace(name: "GESTURE")
        .preferredColorScheme(.dark)
        .animation(.easeInOut, value: location == .zero)
    }
    
    // MARK: Calculating scale for each item with the help of pythagorean theorem(ピタゴラスの定理)
    
    func itemScale(rect: CGRect, size: CGSize) -> CGFloat {
        switch animationEffect {
        case .one, .two:
            let a = location.x - rect.midX
            let b = location.y - rect.midY
            let root = sqrt(a * a + b * b)
            let diagonalValue = sqrt(pow(size.width, 2) + pow(size.height, 2))

            // MARK: For more detail, devide diagonal value
            
            // MARK: Main Grid Magnification Effect
            // Simply Give Any Number (This will be the Circle Size)
            // For the Video I'm Giving 150
            let scale = (root - 150) / 150
            // MARK: For All Other Effects
    //        let scale = root / (diagonalValue / 2)  // nomarization: 正規化？
            let modifiedScale = location == .zero ? 1 : (1 - scale)
            
            // MARK: To avoid SwiftUI transform warning
            return modifiedScale > 0 ? modifiedScale : 0.001
            
        case .three:
            let a = location.x - rect.midX
            let b = location.y - rect.midY
            let root = sqrt(a * a + b * b)  // タッチした場所から離れているほど値は大きくアンル
            let diagonalValue = sqrt(pow(size.width, 2) + pow(size.height, 2))
            
            // MARK: For more detail, devide diagonal value
            let scale = root / (diagonalValue / 2)
            let modifiedScale = location == .zero ? 1 : (1 - scale)
            
            // MARK: To avoid SwiftUI transform warning
            return modifiedScale > 0 ? modifiedScale : 0.001
        }
    }
        
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
