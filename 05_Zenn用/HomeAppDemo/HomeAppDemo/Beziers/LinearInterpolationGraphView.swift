//
//  LinearInterpolationGraphView.swift
//  CubicBezierFromMathToMotionDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/26.
//

import SwiftUI

struct LinearInterpolationGraphView: View {
    
    // MARK: - Properties
    
    @Binding var tValue: CGFloat
    
    private let pointRadius: CGFloat = 20
    private let graphWidth: CGFloat = 6
    
    private var pointP0 = CGPoint(x: 0, y: 0)
    private var pointP1 = CGPoint(x: 1, y: 1)
    var pointP: CGPoint {
        let x = (1 - tValue) * pointP0.x + tValue * pointP1.x
        let y = (1 - tValue) * pointP0.y + tValue * pointP1.y
        
        return CGPoint(x: x, y: y)
    }
    
    // MARK: - LifeCycle
    
    init(tValue: Binding<CGFloat>) {
        self._tValue = tValue
    }
    
    // MARK: - Views
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                // 点P0
                ZStack {
                    Circle()
                        .frame(width: pointRadius, height: pointRadius)
                        .foregroundColor(.red)
                    Text("P0")
                        .foregroundColor(.black)
                        .offset(y: 30)
                        .frame(minWidth: 40)
                }
                .position(
                    CGPoint(x: geometry.size.width * pointP0.x,
                            y: geometry.size.height * pointP0.y)
                )
                .zIndex(1)
                
                // 点P1
                ZStack {
                    Circle()
                        .frame(width: pointRadius, height: pointRadius)
                        .foregroundColor(.red)
                    Text("P1")
                        .foregroundColor(.black)
                        .offset(y: 30)
                        .frame(minWidth: 40)
                }
                .position(
                    CGPoint(x: geometry.size.width * pointP1.x,
                            y: geometry.size.height * pointP1.y)
                )
                .zIndex(1)
                
                // 点P
                ZStack {
                    Circle()
                        .frame(width: pointRadius, height: pointRadius)
                        .foregroundColor(.blue)
                    Text("P")
                        .foregroundColor(.black)
                        .offset(y: 30)
                        .frame(minWidth: 40)
                }
                .position(
                    CGPoint(x: geometry.size.width * pointP.x,
                            y: geometry.size.height * pointP.y)
                )
                .zIndex(1)
                
                // 線形補間
                Path { path in
                    path.move(to: .zero)
                    path.addLine(to: CGPoint(x: geometry.size.width,
                                             y: geometry.size.height))
                }
                .stroke(lineWidth: graphWidth)
                .foregroundStyle(
                    .linearGradient(
                        colors: [.pink, .blue],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                
                Text("P = (\(pointP.x), \(pointP.y))")
                    .offset(x: 0, y: 120)
            }
        }
    }
}

struct LinearInterpolationGraphViewView_Previews: PreviewProvider {
    static var previews: some View {
        
        LinearInterpolationGraphView(tValue: Binding.constant(0.5))
            .frame(width: 400, height: 400)
            .background(.gray.opacity(0.3))
            .previewLayout(.fixed(width: 600, height: 600))
    }
}



