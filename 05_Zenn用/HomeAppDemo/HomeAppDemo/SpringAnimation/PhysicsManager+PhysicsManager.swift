//
//  PhysicsManager+PhysicsManager.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/08/06.
//

import Foundation

extension SpringView {
    
    class PhysicsManager: ObservableObject {
                
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
            
        private var timer: Timer? = nil
        private let spring = Spring()
        
        let standardPoint = CGPoint(x: 200, y: 400)
        var point = Point()
        var frameRate: Double = 1 / 60
        
        func startTimer() {
            timer = Timer.scheduledTimer(withTimeInterval: frameRate, repeats: true) { _ in
                self.updateStatus()
            }
        }
        
        func stopTimer() {
            timer?.invalidate()
            timer = nil
        }
                               
        private func updateStatus() {
            
            let offsetX = point.x - standardPoint.x
            
            let fSpringX = spring.k * offsetX  // フックの法則
//            let fDampingX = spring.d * point.vx
//            let ax = (fSpringX + fDampingX) / point.mass  // 加速度
            
            let ax = fSpringX / point.mass
            
            point.vx = point.vx + ax * frameRate
            point.x = point.x + point.vx * frameRate
        }
        
    }
}
