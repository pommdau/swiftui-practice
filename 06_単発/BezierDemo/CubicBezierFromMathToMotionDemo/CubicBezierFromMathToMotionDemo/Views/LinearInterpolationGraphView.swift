//
//  LinearInterpolationGraphView.swift
//  CubicBezierFromMathToMotionDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/26.
//

import SwiftUI

struct LinearInterpolationGraphView: View {
    
    @Binding var tValue: CGFloat
    
    var pointP: CGPoint {
        let x = (1 - tValue) * 0 + tValue * 1.0
        let y = (1 - tValue) * 0 + tValue * 1.0
        return CGPoint(x: x, y: y)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .frame(width: 28, height: 28)
                    .position(
                        CGPoint(x: geometry.size.width * pointP.x,
                                y: geometry.size.height * pointP.y)
                    )
                    .zIndex(1)
                    .foregroundColor(.blue)
                Path { path in
                    path.move(to: .zero)
                    path.addLine(to: CGPoint(x: geometry.size.width,
                                             y: geometry.size.height))
                }
                .stroke(lineWidth: 10)
                .foregroundStyle(
                    .linearGradient(
                        colors: [.pink, .blue],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            }
        }
    }
}

struct LinearInterpolationGraphViewView_Previews: PreviewProvider {
    static var previews: some View {
        LinearInterpolationGraphView(tValue: Binding.constant(0.5))
            .frame(width: 400, height: 400)
            .background(.gray.opacity(0.3))
    }
}



