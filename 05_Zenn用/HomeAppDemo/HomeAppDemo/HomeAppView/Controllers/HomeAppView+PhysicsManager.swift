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
        var controlAnchor = Anchor(point: .zero)
        var frameRate: Double = 1 / 60
        
        private var timer: Timer? = nil
        private let spring = Spring()
        
        // MARK: - Computed Properties
            
        // P0, P2の中点をP1とする
        private var pointP1: CGPoint {
            let distance = sqrt(
                pow(pointP2.x - pointP0.x, 2) + pow(pointP2.y - pointP0.y, 2)
            )
            let decline = max(0, spring.length - distance)
            
            return .init(x: (pointP0.x + pointP2.x) / 2,
                         y: (pointP0.y + pointP2.y) / 2 + decline)
        }

        var RopePath: Path {
            Path { path in
                path.move(to: pointP0)
                path.addQuadCurve(to: pointP2,
                                  control: controlAnchor.point)
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
            let offsetX = controlAnchor.point.x - pointP1.x
            let offsetY = controlAnchor.point.y - pointP1.y
            let fSpringX = spring.k * offsetX
            let fSpringY = spring.k * offsetY
            let fDampingX = spring.d * controlAnchor.vx
            let fDampingY = spring.d * controlAnchor.vy
            let ax = (fSpringX + fDampingX) / controlAnchor.mass
            let ay = (fSpringY + fDampingY) / controlAnchor.mass
            controlAnchor.vx = controlAnchor.vx + ax * frameRate
            controlAnchor.vy = controlAnchor.vy + ay * frameRate
            controlAnchor.point.x = controlAnchor.point.x + controlAnchor.vx * frameRate
            controlAnchor.point.y = controlAnchor.point.y + controlAnchor.vy * frameRate
        }
    }
}
