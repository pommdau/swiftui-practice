//
//  QuadraticBezierGraphView.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/08/04.
//

import SwiftUI

struct QuadraticBezierGraphView: View {
    
    @Binding var tValue: CGFloat
    
    private let pointRadius: CGFloat = 14
    
    private var pointP0: CGPoint {
        return .init(x: 0, y: 0)
    }
    
    private var pointP1: CGPoint {
        return .init(x: 0.5, y: 1.0)
    }
    
    private var pointP2: CGPoint {
        return .init(x: 1.0, y: 0.0)
    }
    
    private var pointA: CGPoint {
        let x = (1 - tValue) * pointP0.x + tValue * pointP1.x
        let y = (1 - tValue) * pointP0.y + tValue * pointP1.y
        return .init(x: x, y: y)
    }
    
    private var pointB: CGPoint {
        let x = (1 - tValue) * pointP1.x + tValue * pointP2.x
        let y = (1 - tValue) * pointP1.y + tValue * pointP2.y
        return .init(x: x, y: y)
    }
    
    private var pointP: CGPoint {
        let x = pow((1 - tValue), 2) * pointP0.x +
        2 * (1 - tValue) * tValue * pointP1.x +
        pow(tValue, 2) * pointP2.x
        
        let y = pow((1 - tValue), 2) * pointP0.y +
        2 * (1 - tValue) * tValue * pointP1.y +
        pow(tValue, 2) * pointP2.y
        
        return .init(x: x, y: y)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Points()
                    .zIndex(1)
                QuadraticBezierLine()
                AuxiliaryLine()
            }
        }
    }
    
    // MARK: View Parts
    
    @ViewBuilder
    private func Point(label: String, color: Color, position: CGPoint) -> some View {
        ZStack {
            Circle()
                .frame(width: pointRadius, height: pointRadius)
                .foregroundColor(color)
            Text(label)
                .foregroundColor(.black)
                .offset(y: 30)
                .frame(minWidth: 40)
        }
        .position(position)
    }
    
    @ViewBuilder
    private func Points() -> some View {
        GeometryReader { geometry in
            Point(label: "P0", color: .red, position: pointP0.convert(inCanvasSize: geometry.size))
            Point(label: "P1", color: .red, position: pointP1.convert(inCanvasSize: geometry.size))
            Point(label: "P2", color: .red, position: pointP2.convert(inCanvasSize: geometry.size))
            Point(label: "A", color: .red, position: pointA.convert(inCanvasSize: geometry.size))
            Point(label: "B", color: .red, position: pointB.convert(inCanvasSize: geometry.size))
            Point(label: "P", color: .blue, position: pointP.convert(inCanvasSize: geometry.size))
        }
    }
    
    @ViewBuilder
    private func QuadraticBezierLine() -> some View {
        GeometryReader { geometry in
            Path { path in
                path.move(to: pointP0.convert(inCanvasSize: geometry.size))
                path.addQuadCurve(to: pointP2.convert(inCanvasSize: geometry.size),
                                  control: pointP1.convert(inCanvasSize: geometry.size))
                path.addLine(to: pointP2.convert(inCanvasSize: geometry.size))
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
            // 補助線
            Path { path in
                path.move(to: pointP0.convert(inCanvasSize: geometry.size))
                path.addLine(to: pointP1.convert(inCanvasSize: geometry.size))
                path.addLine(to: pointP2.convert(inCanvasSize: geometry.size))
                
                path.move(to: pointA.convert(inCanvasSize: geometry.size))
                path.addLine(to: pointB.convert(inCanvasSize: geometry.size))
            }
            .stroke(lineWidth: 6)
            .foregroundColor(.gray.opacity(0.5))
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



