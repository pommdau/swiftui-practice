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
            var mass: Double = 1  // 質量
            var x: Double = 100
            var vx: Double = 0
        }

        struct Spring {
            var k: Double = -200  // stiffness
            var d: Double = -0  // damping: 減衰振動
        }
        
        // MARK: - Properties
        
        // MARK: Private Properties
        
        private var timer: Timer? = nil
        
        // MARK: Public Properties
        
        @Published var spring = Spring()
        @Published var point = Point()
        let standardPoint = CGPoint(x: 200, y: 200)  // 基準点
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
            let offsetX = point.x - standardPoint.x  // 基準点からどれだけはなれているか(frameRate秒前)
            let fSpringX = spring.k * offsetX  // フックの法則(frameRate秒前)
            let fDampingX = spring.d * point.vx  // 減衰(frameRate秒前)
            let ax = (fSpringX + fDampingX) / point.mass  // 加速度(frameRate秒前)
            
//            point.x = point.x + point.vx * frameRate + ax * frameRate * frameRate  // "x = v0*t + 1/2 * at**2" but 1/2 is error...?
            point.vx = point.vx + ax * frameRate  // 速度(現在)
            point.x = point.x + point.vx * frameRate  // 点(現在)の位置の算出
        }
    }
}
