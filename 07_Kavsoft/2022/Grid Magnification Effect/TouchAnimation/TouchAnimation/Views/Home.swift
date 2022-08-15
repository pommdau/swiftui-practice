//
//  Home.swift
//  TouchAnimation
//
//  Created by HIROKI IKEUCHI on 2022/08/15.
//

import SwiftUI

struct Home: View {
    
    // MARK: Gesture State
    @GestureState var location: CGPoint = .zero
        
    var body: some View {
                
        GeometryReader { proxy in
            let size = proxy.size
            
            //  MARK: To Fit Into Whole View
            // Calculating Item Count with the help of Height & Width
            // In a Row We Have 10 Items
            let width = (size.width / 10)
            
            // Multiplying Each Row Count
            let itemCount = Int((size.height / width).rounded()) * 10
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 10),
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
        let a = location.x - rect.midX
        let b = location.y - rect.midY
        let root = sqrt(a * a + b * b)
        let diagonalValue = sqrt(pow(size.width, 2) + pow(size.height, 2))
                
        // MARK: For more detail, devide diagonal value
        let scale = root / (diagonalValue / 2)  // nomarization: 正規化？
        let modifiedScale = location == .zero ? 1 : (1 - scale)
        
        // MARK: To avoid SwiftUI transform warning
        return modifiedScale > 0 ? modifiedScale : 0.001
    }
        
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
