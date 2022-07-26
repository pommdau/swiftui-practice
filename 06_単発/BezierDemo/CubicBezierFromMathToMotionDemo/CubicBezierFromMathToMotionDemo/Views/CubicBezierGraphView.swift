//
//  CubicBezierGraphView.swift
//  CubicBezierFromMathToMotionDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/26.
//

import SwiftUI

struct CubicBezierGraphView: View {
    
    @Binding var tValue: CGFloat
    private let pointRadius: CGFloat = 14
    
    var pointP0: CGPoint {
        return .init(x: 0.0, y: 1.0)
    }
    
    var pointP1: CGPoint {
        return .init(x: 0.25, y: 0.25)
    }
    
    var pointP2: CGPoint {
        return .init(x: 0.75, y: 0.75)
    }
    
    var pointP3: CGPoint {
        return .init(x: 1.0, y: 0.0)
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                Path { path in
                    path.move(to: pointP0.convert(inCanvasSize: geometry.size))
                    path.addCurve(to: pointP3.convert(inCanvasSize: geometry.size),
                                  control1: pointP1.convert(inCanvasSize: geometry.size),
                                  control2: pointP2.convert(inCanvasSize: geometry.size))
                }
                .stroke(lineWidth: 6)
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

struct CubicBezierGraphView_Previews: PreviewProvider {
    static var previews: some View {
        
        CubicBezierGraphView(tValue: Binding.constant(0.5))
            .frame(width: 400, height: 400)
            .background(.gray.opacity(0.3))
            .previewLayout(.fixed(width: 600, height: 600))
    }
}



