//
//  RopeView.swift
//  CubicBezierFromMathToMotionDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/26.
//

import SwiftUI


struct RopeView: View {
    
    var tValue: CGFloat = 0.3
    private let pointRadius: CGFloat = 14  // 点の直径
    
    @State var pointP0: CGPoint = .init(x: 10, y: 10)

    var pointP1: CGPoint {
        
        let distance = sqrt(
            pow(pointP2.x - pointP0.x, 2) + pow(pointP2.y - pointP0.y, 2)
        )
        let decline = max(0, 600 - distance)  // 近似値？
        
        return .init(x: (pointP0.x + pointP2.x) / 2,
                     y: (pointP0.y + pointP2.y) / 2 + decline)
    }
        
    @State var pointP2: CGPoint = .init(x: 400, y: 10)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                               
                Points()
                
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
                }
                .stroke(lineWidth: 6)
                .foregroundColor(.gray.opacity(0.5))
                
            }
            .background(.yellow.opacity(0.2))
            .simultaneousGesture(
                DragGesture()
                    .onChanged { gesture in
//                        gesture.location
                        pointP2 = gesture.location
                    }
                    .onEnded { gesture in
                        print(gesture)
                    }
            )
        }
    }
    
    func updateLocation(_ location: CGPoint) {
        pointP2 = location
    }
    
    @ViewBuilder
    private func Points() -> some View {
        GeometryReader { geometry in
            Group {
                Circle()
                    .position(pointP0)
                Circle()
                    .position(pointP2)
            }
            .foregroundColor(.red)
            .frame(width: pointRadius, height: pointRadius)
        }
    }
}

struct RopeView_Previews: PreviewProvider {
    static var previews: some View {
        RopeView(tValue: 0.3)
            .frame(width: 400, height: 400)
            .previewLayout(.fixed(width: 600, height: 600))
    }
}



