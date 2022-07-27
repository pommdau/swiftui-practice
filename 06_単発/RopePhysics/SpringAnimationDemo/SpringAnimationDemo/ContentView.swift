//
//  ContentView.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/26.
//

import SwiftUI

struct Point {
    let mass: Double = 1  // 質量
    var x: Double = 100
    var v: Double = 0
}

struct Spring {
    let springLength: Double = 0
    var k: Double = -20  // stiffness: 20
    let d = -0.5  // damping: 減衰振動
//    let d: Double = 0.0
}

class PhysicsManager: ObservableObject {
    private var timer: Timer? = nil
    var point = Point()
    private let spring = Spring()
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: frameRate, repeats: true) { _ in
            self.updateStatus()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
                    
    var frameRate: Double = 1 / 60
    
    private func updateStatus() {
        let fSpring = spring.k * (point.x - spring.springLength)  // フックの法則
        let fDamping = spring.d * point.v
        let a = (fSpring + fDamping) / point.mass  // 加速度
        point.v = point.v + a * frameRate
        point.x = point.x + point.v * frameRate  // x=v0t+1/2at^2ではなく前の位置を使用する(同じ意味ではある)
    }
    
}

struct ContentView: View {
    
    @ObservedObject var physicsManager = PhysicsManager()
    
    var body: some View {
        TimelineView(.periodic(from: Date(), by: physicsManager.frameRate)) { _ in
            
            VStack {
                
                Text("\(physicsManager.point.x)")
                
                ZStack {
                    Circle()
                        .position(CGPoint(x: 10, y: 200 + physicsManager.point.x))
                        .frame(width: 30, height: 30)
                        .foregroundColor(.red)
                    Circle()
                        .position(CGPoint(x: 10, y: 200))
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                }
            }
            
        }
        .onAppear {
            physicsManager.startTimer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
