//
//  RopeView.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/27.
//

import SwiftUI

class PhysicsManager: ObservableObject {
    
    struct Point {
        let mass: Double = 1  // 質量
        var x: Double = 100
        var y: Double = 100
        var vx: Double = 0
        var vy: Double = 0
    }

    struct Spring {
        let springLength: Double = 0
        let k: Double = -200  // stiffness: 20
        let d: Double = -2.0  // damping: 減衰振動
    }
        
    private var timer: Timer? = nil
    private let spring = Spring()
    
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
        let fSpringX = spring.k * (point.x - spring.springLength)  // フックの法則
        let fSpringY = spring.k * (point.y - spring.springLength)
        let fDampingX = spring.d * point.vx
        let fDampingY = spring.d * point.vy
        let ax = (fSpringX + fDampingX) / point.mass  // 加速度
        let ay = (fSpringY + fDampingY) / point.mass  // 加速度
        
        point.vx = point.vx + ax * frameRate
        point.vy = point.vy + ay * frameRate
        point.x = point.x + point.vx * frameRate
        point.y = point.y + point.vy * frameRate  // x=v0t+1/2at^2ではなく前の位置を使用する(同じ意味ではある)
    }
    
}

struct RopeView: View {
    
    @ObservedObject var physicsManager = PhysicsManager()
    @State private var touchPoint: CGPoint = .zero
    
    var body: some View {
        TimelineView(.periodic(from: Date(), by: 1/60)) { _ in
            VStack {
                ZStack {
                    Circle()
                        .position(CGPoint(x: physicsManager.point.x, y: physicsManager.point.y))
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                }
            }
        }
        .position(x: 0, y: 0)
        //        .position(x: 10, y: 10)
        //        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.green)
        .simultaneousGesture(
            DragGesture()
                .onChanged { gesture in
                    physicsManager.point.x = gesture.location.x
                    physicsManager.point.y = gesture.location.y
                }
                .onEnded { gesture in
                    
                }
        )
        .onAppear() {
//            physicsManager.startTimer()
        }
    }
}

struct RopeView_Previews: PreviewProvider {
    static var previews: some View {
        RopeView()
    }
}
