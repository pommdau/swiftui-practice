//
//  QuadraticBezierGraphView.swift
//  CubicBezierFromMathToMotionDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/26.
//

import SwiftUI

struct QuadraticBezierGraphView: View {
    
    @Binding var tValue: CGFloat
    
    var pointP0: CGPoint {
        return .zero
    }
    
    var pointP1: CGPoint {
        return CGPoint(x: 0.5, y: 1)
    }
    
    var pointP2: CGPoint {
        return CGPoint(x: 1, y: 0)
    }
    
    var pointA: CGPoint {
        return .zero
    }
    
//    var pointP: CGPoint {
//        let x = (1 - tValue) * 0 + tValue * 1.0
//        let y = (1 - tValue) * 0 + tValue * 1.0
//        return CGPoint(x: x, y: y)
//    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                Circle()
                    .frame(width: 28, height: 28)
                    .position(
                        pointA.convert(inCanvasSize: geometry.size)
                    )
                    .zIndex(1)
                    .foregroundColor(.red)
                
                Circle()
                    .frame(width: 28, height: 28)
                    .position(
                        pointP2.convert(inCanvasSize: geometry.size)
                    )
                    .zIndex(1)
                    .foregroundColor(.red)
                
                
//                Circle()
//                    .frame(width: 28, height: 28)
//                    .position(
//                        CGPoint(x: geometry.size.width * pointP.x,
//                                y: geometry.size.height * pointP.y)
//                    )
//                    .zIndex(1)
                //                    .foregroundColor(.blue)
                Path { path in
                    path.move(to: pointP0.convert(inCanvasSize: geometry.size))
                    path.addQuadCurve(to: pointP2.convert(inCanvasSize: geometry.size),
                                      control: pointP1.convert(inCanvasSize: geometry.size))
                    path.addLine(to: pointP2.convert(inCanvasSize: geometry.size))
                }
                .stroke(lineWidth: 10)
                .foregroundStyle(
                    .linearGradient(
                        colors: [.pink, .blue, .pink],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            }
        }
    }
}

struct QuadraticBezierGraphView_Previews: PreviewProvider {
    static var previews: some View {
        
        QuadraticBezierGraphView(tValue: Binding.constant(0.5))
            .frame(width: 400, height: 400)
            .background(.gray.opacity(0.3))
            .previewLayout(.fixed(width: 600, height: 600))
    }
}



