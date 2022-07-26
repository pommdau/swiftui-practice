//
//  RopeView.swift
//  CubicBezierFromMathToMotionDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/26.
//

import SwiftUI


struct RopeView: View {
    
    enum DraggingStatus {
        case none
        case isDraggingP0
        case isDraggingP2
    }
    
    var tValue: CGFloat = 0.5
    private let pointRadius: CGFloat = 28  // 点の直径
    @State private var draggingStatus: DraggingStatus = .none
    
    @State var pointP0: CGPoint = .init(x: 10, y: 10)
    @State var pointP2: CGPoint = .init(x: 400, y: 10)
    
    // P0, P2の中点をP1とする
    var pointP1: CGPoint {
        let distance = sqrt(
            pow(pointP2.x - pointP0.x, 2) + pow(pointP2.y - pointP0.y, 2)
        )
        let decline = max(0, 600 - distance / 2)  // 近似値？
        
        return .init(x: (pointP0.x + pointP2.x) / 2,
                     y: (pointP0.y + pointP2.y) / 2 + decline)
    }
    
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
                        switch draggingStatus {
                        case .none:
                            if bothPointsAreClose(point1: pointP0, point2: gesture.location) {
                                draggingStatus = .isDraggingP0
                            } else if bothPointsAreClose(point1: pointP2, point2: gesture.location) {
                                draggingStatus = .isDraggingP2
                            }
                        case .isDraggingP0:
                            pointP0 = gesture.location
                        case .isDraggingP2:
                            pointP2 = gesture.location
                        }
                    }
                    .onEnded { gesture in
                        draggingStatus = .none
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
                    .stroke(.blue, lineWidth: 2)
                    .background(Circle().fill(.blue.opacity(0.3)))
                    .position(pointP0)
                Circle()
                    .stroke(.blue, lineWidth: 2)
                    .background(Circle().fill(.blue.opacity(0.3)))
                    .position(pointP2)
            }
            .frame(width: pointRadius, height: pointRadius)
        }
    }
    
    private func bothPointsAreClose(point1: CGPoint, point2: CGPoint) -> Bool {
        return abs(point1.x - point2.x) < pointRadius / 2 &&
        abs(point1.y - point2.y) < pointRadius / 2
    }
}

struct RopeView_Previews: PreviewProvider {
    static var previews: some View {
        RopeView()
            .frame(width: 400, height: 400)
            .previewLayout(.fixed(width: 600, height: 600))
    }
}



