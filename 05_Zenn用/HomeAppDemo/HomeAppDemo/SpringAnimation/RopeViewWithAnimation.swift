//
//  RopeViewWithAnimation.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/08/07.
//

import SwiftUI


struct RopeViewWithAnimation: View {
    
    // MARK: - Properties
    
    // MARK: Private Properties
    
    private let pointRadius: CGFloat = 20
    
    // MARK: Public Properties
    
    @ObservedObject var pointsManager = PointsManager(pointP0: .init(x: 100, y: 100),
                                                      pointP2: .init(x: 300, y: 150))
        
    // MARK: - View
    
    var body: some View {
        
        ZStack {
            TimelineView(.periodic(from: Date(), by: pointsManager.frameRate)) { context in
                ZStack {
                    QuadraticBezierLine()
                    AuxiliaryLine()
                    Points()
                }
            }
        }
        .ignoresSafeArea()
        .background(.gray.opacity(0.5))
        .onAppear {
            pointsManager.startTimer()
        }
        .onDisappear {
            pointsManager.stopTimer()
        }
        .onTapGesture(coordinateSpace: .global) { location in
//            pointsManager.point.vx = 0
//            pointsManager.point.x = location.x
        }
        .gesture(
            DragGesture(minimumDistance: 4, coordinateSpace: .global)
                .onChanged({ (value) in
                    print(value)
                })
        )
    }
    
    @ViewBuilder
    private func Points() -> some View {
        Circle()
            .frame(width: pointRadius, height: pointRadius)
            .foregroundColor(.red)
            .position(pointsManager.pointP0)
            .gesture(dragGestureForPointP0)
                        
        Circle()
            .frame(width: pointRadius, height: pointRadius)
            .foregroundColor(.red)
            .position(pointsManager.pointP2)
            .gesture(dragGestureForPointP2)
        
        Circle()
            .frame(width: pointRadius, height: pointRadius)
            .foregroundColor(.green)
            .position(pointsManager.pointP1)
        
        Circle()
            .frame(width: pointRadius, height: pointRadius)
            .foregroundColor(.red)
            .position(pointsManager.controlPoint.point)
    }
    
    @ViewBuilder
    private func QuadraticBezierLine() -> some View {
        Path { path in
            path.move(to: pointsManager.pointP0)
            path.addQuadCurve(to: pointsManager.pointP2,
                              control: pointsManager.controlPoint.point)
            path.addLine(to: pointsManager.pointP2)
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
    
    // 補助線
    @ViewBuilder
    private func AuxiliaryLine() -> some View {
        Path { path in
            path.move(to: pointsManager.pointP0)
            path.addLine(to: pointsManager.controlPoint.point)
            path.addLine(to: pointsManager.pointP2)
        }
        .stroke(lineWidth: 6)
        .foregroundColor(.gray.opacity(0.5))
    }
    
    var dragGestureForPointP0: some Gesture {
        DragGesture()
            .onChanged{ value in
                pointsManager.pointP0 = CGPoint(
                    x: value.startLocation.x
                    + value.translation.width,
                    y: value.startLocation.y
                    + value.translation.height
                )
            }
            .onEnded{ value in
                pointsManager.pointP0 = CGPoint(
                    x: value.startLocation.x + value.translation.width,
                    y: value.startLocation.y + value.translation.height
                )
            }
    }
    
    var dragGestureForPointP2: some Gesture {
        DragGesture()
            .onChanged{ value in
                pointsManager.pointP2 = CGPoint(
                    x: value.startLocation.x + value.translation.width,
                    y: value.startLocation.y + value.translation.height
                )
            }
            .onEnded{ value in
                pointsManager.pointP2 = CGPoint(
                    x: value.startLocation.x + value.translation.width,
                    y: value.startLocation.y + value.translation.height
                )
            }
    }
}

struct RopeViewWithAnimation_Previews: PreviewProvider {
    static var previews: some View {
        RopeViewWithAnimation()
    }
}
