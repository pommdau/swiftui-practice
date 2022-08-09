//
//  CubicBezierGraphView.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/08/09.
//

import SwiftUI

struct CubicBezierGraphView: View {
    
    @Binding var tValue: CGFloat
    private let pointRadius: CGFloat = 14
    
    var pointP0: CGPoint {
        return .init(x: 0, y: 0)
    }
    
    var pointP1: CGPoint {
        return .init(x: 0.5, y: 1.0)
    }
    
    var pointP2: CGPoint {
        return .init(x: 1.0, y: 0.0)
    }
    
    var pointA: CGPoint {
        let x = (1 - tValue) * pointP0.x + tValue * pointP1.x
        let y = (1 - tValue) * pointP0.y + tValue * pointP1.y
        return .init(x: x, y: y)
    }
    
    var pointB: CGPoint {
        let x = (1 - tValue) * pointP1.x + tValue * pointP2.x
        let y = (1 - tValue) * pointP1.y + tValue * pointP2.y
        return .init(x: x, y: y)
    }
    
    var pointP: CGPoint {
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
    private func Points() -> some View {
        GeometryReader { geometry in
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
                pointP0.convert(inCanvasSize: geometry.size)
            )
            
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
                pointP1.convert(inCanvasSize: geometry.size)
            )
            
            ZStack {
                Circle()
                    .frame(width: pointRadius, height: pointRadius)
                    .foregroundColor(.red)
                Text("P2")
                    .foregroundColor(.black)
                    .offset(y: 30)
                    .frame(minWidth: 40)
            }
            .position(
                pointP2.convert(inCanvasSize: geometry.size)
            )
            
            ZStack {
                Circle()
                    .frame(width: pointRadius, height: pointRadius)
                    .foregroundColor(.red)
                Text("A")
                    .foregroundColor(.black)
                    .offset(y: 30)
                    .frame(minWidth: 40)
            }
            .position(
                pointA.convert(inCanvasSize: geometry.size)
            )
            
            ZStack {
                Circle()
                    .frame(width: pointRadius, height: pointRadius)
                    .foregroundColor(.red)
                Text("B")
                    .foregroundColor(.black)
                    .offset(y: 30)
                    .frame(minWidth: 40)
            }
            .position(
                pointB.convert(inCanvasSize: geometry.size)
            )
            
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
                pointP.convert(inCanvasSize: geometry.size)
            )
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

struct CubicBezierGraphView_Previews: PreviewProvider {
    static var previews: some View {
        
        CubicBezierGraphView(tValue: Binding.constant(0.5))
            .frame(width: 400, height: 400)
            .background(.gray.opacity(0.3))
            .previewLayout(.fixed(width: 600, height: 600))
    }
}



