//
//  RopeViewWithoutAnimation.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/08/04.
//

import SwiftUI


struct RopeViewWithoutAnimation: View {
    
    private let pointRadius: CGFloat = 20
    private let ropeLength: CGFloat = 400
    @State var pointP0: CGPoint = .init(x: 100, y: 100)
    @State var pointP2: CGPoint = .init(x: 300, y: 100)
    
    // P1: 制御点(Control Point)
    var pointP1: CGPoint {
        let distance = sqrt(
            pow(pointP2.x - pointP0.x, 2) + pow(pointP2.y - pointP0.y, 2)
        )
        let decline = max(0, 400 - distance / 2)  // それっぽい近似値とする
        
        return .init(x: (pointP0.x + pointP2.x) / 2,
                     y: (pointP0.y + pointP2.y) / 2 + decline)
    }
    
    var body: some View {
        ZStack {
            Points()
            QuadraticBezierLine()
            AuxiliaryLine()
        }
    }
    
    var dragGestureP0: some Gesture {
        DragGesture()
            .onChanged{ value in
                pointP0 = CGPoint(
                    x: value.startLocation.x
                    + value.translation.width,
                    y: value.startLocation.y
                    + value.translation.height
                )
            }
            .onEnded{ value in
                pointP0 = CGPoint(
                    x: value.startLocation.x
                    + value.translation.width,
                    y: value.startLocation.y
                    + value.translation.height
                )
            }
        
    }
    
    var dragGestureP2: some Gesture {
        DragGesture()
            .onChanged{ value in
                pointP2 = CGPoint(
                    x: value.startLocation.x
                    + value.translation.width,
                    y: value.startLocation.y
                    + value.translation.height
                )
            }
            .onEnded{ value in
                pointP2 = CGPoint(
                    x: value.startLocation.x
                    + value.translation.width,
                    y: value.startLocation.y
                    + value.translation.height
                )
            }
    }
    
    @ViewBuilder
    private func Points() -> some View {
        ZStack {
            Circle()
                .frame(width: pointRadius, height: pointRadius)
                .foregroundColor(.red)
                .position(pointP0)
                .gesture(dragGestureP0)
            
            Circle()
                .frame(width: pointRadius, height: pointRadius)
                .foregroundColor(.red)
                .position(pointP2)
                .gesture(dragGestureP2)
            
            Circle()
                .frame(width: pointRadius, height: pointRadius)
                .foregroundColor(.red)
                .position(pointP1)
        }
    }
    
    @ViewBuilder
    private func QuadraticBezierLine() -> some View {
        Path { path in
            path.move(to: pointP0)
            path.addQuadCurve(to: pointP2,
                              control: pointP1)
            path.addLine(to: pointP2)
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
    
    @ViewBuilder
    private func AuxiliaryLine() -> some View {
        // 補助線
        Path { path in
            path.move(to: pointP0)
            path.addLine(to: pointP1)
            path.addLine(to: pointP2)
        }
        .stroke(lineWidth: 6)
        .foregroundColor(.gray.opacity(0.5))
    }
}

struct RopeViewWithoutSpring_Previews: PreviewProvider {
    static var previews: some View {
        RopeViewWithoutAnimation()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
