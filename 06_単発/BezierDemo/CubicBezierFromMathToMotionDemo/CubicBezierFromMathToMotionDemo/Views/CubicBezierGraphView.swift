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
    
    // MARK: Constant
    
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
    
    // MARK: - Dynamic
    
    // MARK: Red Point
    
    var pointR0: CGPoint {
        let x = (1 - tValue) * pointP0.x + tValue * pointP1.x
        let y = (1 - tValue) * pointP0.y + tValue * pointP1.y
        return .init(x: x, y: y)
    }
    
    var pointR1: CGPoint {
        let x = (1 - tValue) * pointP1.x + tValue * pointP2.x
        let y = (1 - tValue) * pointP1.y + tValue * pointP2.y
        return .init(x: x, y: y)
    }
    
    var pointR2: CGPoint {
        let x = (1 - tValue) * pointP2.x + tValue * pointP3.x
        let y = (1 - tValue) * pointP2.y + tValue * pointP3.y
        return .init(x: x, y: y)
    }
    
    // MARK: Green Point
    
    var pointG0: CGPoint {
        let px = pow((1 - tValue), 2) * pointP0.x +
        2 * (1 - tValue) * tValue * pointP1.x +
        pow(tValue, 2) * pointP2.x

        let py = pow((1 - tValue), 2) * pointP0.y +
        2 * (1 - tValue) * tValue * pointP1.y +
        pow(tValue, 2) * pointP2.y

        return .init(x: px, y: py)
    }
    
    var pointG1: CGPoint {
        let px = pow((1 - tValue), 2) * pointP1.x +
        2 * (1 - tValue) * tValue * pointP2.x +
        pow(tValue, 2) * pointP3.x

        let py = pow((1 - tValue), 2) * pointP1.y +
        2 * (1 - tValue) * tValue * pointP2.y +
        pow(tValue, 2) * pointP3.y

        return .init(x: px, y: py)
    }
        
    var pointP: CGPoint {
        let px = pow((1 - tValue), 3) * pointP0.x +
        tValue * pointP1.x * 3 * pow((1 - tValue), 2) +
        pointP2.x * 3 * (1 - tValue) * pow(tValue, 2) +
        pointP3.x * pow(tValue, 3)

        let py = pow((1 - tValue), 3) * pointP0.y +
        tValue * pointP1.y * 3 * pow((1 - tValue), 2) +
        pointP2.y * 3 * (1 - tValue) * pow(tValue, 2) +
        pointP3.y * pow(tValue, 3)

        return .init(x: px, y: py)
    }
    
    // MARK: - Views

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Points()
                    .zIndex(1)
                CubicBezierLine()
                AuxiliaryLine()
            }
        }
    }
    
    // MARK: View Parts
    
    @ViewBuilder
    private func Points() -> some View {
        GeometryReader { geometry in
            Group {
                Group {
                    Circle()
                        .position(pointR0.convert(inCanvasSize: geometry.size))
                    Circle()
                        .position(pointR1.convert(inCanvasSize: geometry.size))
                    Circle()
                        .position(pointR2.convert(inCanvasSize: geometry.size))
                }
                .foregroundColor(.red)
                
                Group {
                    Circle()
                        .position(pointG0.convert(inCanvasSize: geometry.size))
                    Circle()
                        .position(pointG1.convert(inCanvasSize: geometry.size))
                }
                .foregroundColor(.green)
                
                Circle()
                    .position(pointP.convert(inCanvasSize: geometry.size))
                    .foregroundColor(.blue)
            }
            .frame(width: pointRadius, height: pointRadius)
        }
    }
    
    @ViewBuilder
    private func CubicBezierLine() -> some View {
        GeometryReader { geometry in
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
    
    @ViewBuilder
    private func AuxiliaryLine() -> some View {
        GeometryReader { geometry in
            Path { path in
                path.move(to: pointP0.convert(inCanvasSize: geometry.size))
                path.addLine(to: pointP1.convert(inCanvasSize: geometry.size))
                path.addLine(to: pointP2.convert(inCanvasSize: geometry.size))
                path.addLine(to: pointP3.convert(inCanvasSize: geometry.size))
                
                path.move(to: pointR0.convert(inCanvasSize: geometry.size))
                path.addLine(to: pointR1.convert(inCanvasSize: geometry.size))
                
                path.move(to: pointR1.convert(inCanvasSize: geometry.size))
                path.addLine(to: pointR2.convert(inCanvasSize: geometry.size))
                
                path.move(to: pointG0.convert(inCanvasSize: geometry.size))
                path.addLine(to: pointG1.convert(inCanvasSize: geometry.size))
            }
            .stroke(lineWidth: 2)
            .foregroundColor(.gray.opacity(0.5))
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



