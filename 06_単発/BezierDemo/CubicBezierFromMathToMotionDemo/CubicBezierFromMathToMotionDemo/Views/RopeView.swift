//
//  RopeView.swift
//  CubicBezierFromMathToMotionDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/26.
//

import SwiftUI


struct RopeView: View {
    
    var tValue: CGFloat = 0.3
    private let pointRadius: CGFloat = 14
    
    var pointP0: CGPoint {
        return .init(x: 10, y: 10)
    }
    
//    var pointP1: CGPoint {
//        return .init(x: 200, y: 300)
//    }
    
    var pointP1: CGPoint {
        
        let distance = sqrt(
            pow(pointP2.x - pointP0.x, 2) + pow(pointP2.y - pointP0.y, 2)
        )
        let decline = max(0, 600 - distance)  // 近似値？
        
        return .init(x: (pointP0.x + pointP2.x) / 2,
                     y: (pointP0.y + pointP2.y) / 2 + decline)
    }
        
    @State var pointP2: CGPoint = .init(x: 400, y: 10)
    
    var pointA: CGPoint {
        let ax = (1 - tValue) * pointP0.x + tValue * pointP1.x
        let ay = (1 - tValue) * pointP0.y + tValue * pointP1.y
        return .init(x: ax, y: ay)
    }
    
    var pointB: CGPoint {
        let ax = (1 - tValue) * pointP1.x + tValue * pointP2.x
        let ay = (1 - tValue) * pointP1.y + tValue * pointP2.y
        return .init(x: ax, y: ay)
    }
    
    var pointP: CGPoint {
        let px = pow((1 - tValue), 2) * pointP0.x +
        2 * (1 - tValue) * tValue * pointP1.x +
        pow(tValue, 2) * pointP2.x
        
        let py = pow((1 - tValue), 2) * pointP0.y +
        2 * (1 - tValue) * tValue * pointP1.y +
        pow(tValue, 2) * pointP2.y
        
        return .init(x: px, y: py)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                Circle()
                    .frame(width: pointRadius, height: pointRadius)
                    .position(
                        pointA
                    )
                    .zIndex(1)
                    .foregroundColor(.red)
                
                Circle()
                    .frame(width: pointRadius, height: pointRadius)
                    .position(
                        pointB
                    )
                    .zIndex(1)
                    .foregroundColor(.red)
                
                Circle()
                    .frame(width: pointRadius, height: pointRadius)
                    .position(
                        pointP
                    )
                    .zIndex(1)
                    .foregroundColor(.blue)
                
                Circle()
                    .frame(width: pointRadius, height: pointRadius)
                    .position(
                        pointP1
                    )
                    .zIndex(1)
                    .foregroundColor(.orange)
                
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
                
                // 補助線
                Path { path in
                    path.move(to: pointP0)
                    path.addLine(to: pointP1)
                    path.addLine(to: pointP2)
                    
                    path.move(to: pointA)
                    path.addLine(to: pointB)
                }
                .stroke(lineWidth: 6)
                .foregroundColor(.gray.opacity(0.5))
                
            }
            .onTouch(limitToBounds: false,
                     perform: updateLocation)
            .background(.yellow.opacity(0.2))
        }
    }
    
    func updateLocation(_ location: CGPoint) {
//        print(location)
        pointP2 = location
    }
}

struct RopeView_Previews: PreviewProvider {
    static var previews: some View {
        RopeView(tValue: 0.3)
            .frame(width: 400, height: 400)
//            .background(.gray.opacity(0.3))
            .previewLayout(.fixed(width: 600, height: 600))
    }
}



