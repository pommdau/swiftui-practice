//
//  HomeAppView+PhysicsManager.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/08/10.
//

import SwiftUI

extension HomeAppView {

    class PhysicsManager: ObservableObject {
        
        struct Anchor {
            let mass: Double = 1  // 質量
            var point: CGPoint = .zero
            var vx: Double = 0
            var vy: Double = 0
        }
        
        struct Spring {
            let length: Double = 400
            let k: Double = -200  // stiffness: 20
            let d: Double = -10  // damping: 減衰振動
        }
        
        // MARK: - Properties
                    
        var pointP0: CGPoint
        var pointP2: CGPoint
        var anchor = Anchor(point: .zero)
        var frameRate: Double = 1 / 60
    //    var frameRate: Double = 0.1
        
        private var timer: Timer? = nil
        private let spring = Spring()
        
        // MARK: - Computed Properties
            
        // P0, P2の中点をP1とする
        private var pointP1: CGPoint {
            let distance = sqrt(
                pow(pointP2.x - pointP0.x, 2) + pow(pointP2.y - pointP0.y, 2)
            )
            let decline = max(0, spring.length - distance)  // 近似値？
            
            return .init(x: (pointP0.x + pointP2.x) / 2,
                         y: (pointP0.y + pointP2.y) / 2 + decline)
        }

        var RopePath: Path {
            Path { path in
                path.move(to: pointP0)
                path.addQuadCurve(to: pointP2,
                                  control: anchor.point)
            }
        }
        
        // MARK: - LifeCycle
        
        init(pointP0: CGPoint, pointP2: CGPoint) {
            self.pointP0 = pointP0
            self.pointP2 = pointP2
        }
        
        // MARK: - Timer
        
        func startTimer() {
            timer = Timer.scheduledTimer(withTimeInterval: frameRate, repeats: true) { _ in
                self.updateStatus()
            }
        }
        
        func stopTimer() {
            timer?.invalidate()
            timer = nil
        }
        
        // MARK: - Helpers
        
        private func updateStatus() {
            let offsetX = anchor.point.x - pointP1.x
            let offsetY = anchor.point.y - pointP1.y
            
            let fSpringX = spring.k * offsetX  // フックの法則
            let fSpringY = spring.k * offsetY
            let fDampingX = spring.d * anchor.vx
            let fDampingY = spring.d * anchor.vy
            let ax = (fSpringX + fDampingX) / anchor.mass  // 加速度
            let ay = (fSpringY + fDampingY) / anchor.mass  // 加速度
            
            anchor.vx = anchor.vx + ax * frameRate
            anchor.vy = anchor.vy + ay * frameRate
            anchor.point.x = anchor.point.x + anchor.vx * frameRate
            anchor.point.y = anchor.point.y + anchor.vy * frameRate  // x=v0t+1/2at^2ではなく前の位置を使用する(同じ意味ではある)
        }
        
        private func calculate() -> CGPoint {
            return .zero
        }
    }

}
