//
//  RopeViewWithAnimation+PointsManager.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/08/07.
//

import SwiftUI

extension RopeViewWithAnimation {
    
    // TimerをPropertyに持つのでstructではなくclassで定義
    class PointsManager: ObservableObject {
        
        // MARK: - Definition
        
        struct Point {
            var mass: Double = 1  // 質量
            var x: Double = 0
            var y: Double = 0
            var vx: Double = 0
            var vy: Double = 0
        }

        struct Spring {
            var k: Double = -200  // stiffness
            var d: Double = -0  // damping: 減衰振動
        }
        
        // MARK: - Properties
        
        // MARK: Private Properties
        
        private var timer: Timer? = nil
        private let ropeLength: CGFloat = 400
        
        // MARK: Public Properties
        
        @Published var spring = Spring()
        var frameRate: Double = 1 / 60
        var pointP0: CGPoint
        var pointP2: CGPoint
        var controlPoint: Point = Point()  // 実際に使用する二次ベジェ曲線の制御点
        
        // 基準になる二次ベジェ曲線の制御点。controlPointがこの点に収束する。
        private var pointP1: CGPoint {
            let distance = sqrt(
                pow(pointP2.x - pointP0.x, 2) + pow(pointP2.y - pointP0.y, 2)
            )
            let decline = max(0, ropeLength - distance)  // 近似値？
            
            return .init(x: (pointP0.x + pointP2.x) / 2,
                         y: (pointP0.y + pointP2.y) / 2 + decline)
        }
        
        
        // MARK: - LifeCycle
        
        init(pointP0: CGPoint, pointP2: CGPoint) {
            self.pointP0 = pointP0
            self.pointP2 = pointP2
        }
        
        // MARK: - Timer Methods
        
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
            let offsetX = controlPoint.x - pointP1.x
            let offsetY = controlPoint.y - pointP1.y
            let fSpringX = spring.k * offsetX  // フックの法則
            let fSpringY = spring.k * offsetY  // フックの法則
            let fDampingX = spring.d * controlPoint.vx
            let fDampingY = spring.d * controlPoint.vy
            let ax = (fSpringX + fDampingX) / controlPoint.mass
            let ay = (fSpringY + fDampingY) / controlPoint.mass
            
            controlPoint.vx = controlPoint.vx + ax * frameRate
            controlPoint.vy = controlPoint.vy + ay * frameRate
            controlPoint.x = controlPoint.x + controlPoint.vx * frameRate
            controlPoint.y = controlPoint.y + controlPoint.vy * frameRate
        }
    }
}
