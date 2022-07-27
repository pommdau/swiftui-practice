//
//  TimelineViewTestView.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/27.
//

import SwiftUI

struct TimelineViewTestView: View {
    
    @State private var count = 0
    @State private var touchPoint: CGPoint = .init(x: 200, y: 200)
    
    var body: some View {
        TimelineView(.periodic(from: Date(), by: 1/60)) { context in
            ZStack {
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
                    .position(touchPoint)
                
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
                    .position(CGPoint(x: 200, y: 200))
                
                Path { path in
                    path.move(to: touchPoint)
                    path.addLine(to: CGPoint(x: 200, y: 200))
//                    path.move(to: physicsManager.pointP0)
//                    path.addQuadCurve(to: physicsManager.pointP2,
//                                      control: physicsManager.pointP1)
//                        path.addLine(to: physicsManager.pointP2)
                }
                .stroke(lineWidth: 6)
                .foregroundStyle(
                    .linearGradient(
                        colors: [.pink, .blue, .pink],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                
//                Canvas { context, size in
//                    context.fill(getPath(size: size, point: touchPoint),
//                                 with: .color(.blue))
//                    
//                    context
//                        .stroke(circlePath(point: touchPoint), with: .color(.red))
//                    context
//                        .fill(circlePath(point: touchPoint), with: .color(.red.opacity(0.3)))
//                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.green)
        .simultaneousGesture(
            DragGesture()
                .onChanged { gesture in
                    touchPoint = gesture.location
                }
                .onEnded { gesture in
                    
                }
        )
    }
    
    private func circlePath(point: CGPoint) -> Path {
        Path { path in
            path.addArc(
                center: point,
                radius: 20,
                startAngle: .degrees(0),
                endAngle: .degrees(360),
                clockwise: false
            )
            path.closeSubpath()
        }
        
    }
    
    private func getPath(size: CGSize, point: CGPoint) -> Path {
        return Path { path in
            let midHeight = size.height / 2
            let width = size.width
            
            // moving the wave to center leading
            path.move(to: touchPoint)
            path.addLine(to: CGPoint(x: width, y: size.height))
            path.addLine(to: CGPoint(x: 0, y: size.height))
        }
    }
}

struct TimelineViewTestView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineViewTestView()
    }
}
