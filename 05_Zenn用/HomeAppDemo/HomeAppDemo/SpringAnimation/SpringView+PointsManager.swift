//
//  SpringView+PointsManager.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/08/06.
//

import SwiftUI

extension SpringView {
    
    // TimerをPropertyに持つのでstructではなくclassで定義
    class PointsManager: ObservableObject {
        
        // MARK: - Definition
        
        struct Point {
            let mass: Double = 1  // 質量
            var x: Double = 100
            var vx: Double = 0
        }

        struct Spring {
            let springLength: Double = 0
            let k: Double = -200  // stiffness: 20
            let d: Double = -2.0  // damping: 減衰振動
        }
        
        // MARK: - Properties
        
        // MARK: Private Properties
        
        private var timer: Timer? = nil
        private let spring = Spring()
        @Published var usingDumping: Bool = true
        
        // MARK: Public Properties
        
        var point = Point()
        let standardPoint = CGPoint(x: 200, y: 400)
        var frameRate: Double = 1 / 60
        
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
            let offsetX = point.x - standardPoint.x
            let fSpringX = spring.k * offsetX  // フックの法則
            
            
            let ax: CGFloat
            if usingDumping {
                let fDampingX = spring.d * point.vx
                ax = (fSpringX + fDampingX) / point.mass  // 加速度
            } else {
                ax = fSpringX / point.mass
            }
            
            point.vx = point.vx + ax * frameRate
            point.x = point.x + point.vx * frameRate
        }
    }
}
