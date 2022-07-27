//
//  ContentView.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/26.
//

import SwiftUI

class PhysicsManager: ObservableObject {
    private var timer: Timer? = nil
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: frameRate, repeats: true) { _ in
            self.updateStatus()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    let mass: Double = 1  // 質量
    let springLength: Double = 0
    var x: Double = 100
    var v: Double = 0
    var k: Double = -20  // stiffness: 20
    let d = -0.5  // damping: 減衰振動
//    let d: Double = 0.0
    var frameRate: Double = 1 / 60
    var positions = [CGFloat]()
    
    private func updateStatus() {
        let fSpring = k * (x - springLength)  // フックの法則
        let fDamping = d * v
        let a = (fSpring + fDamping) / mass  // 加速度
        v = v + a * frameRate
        x = x + v * frameRate  // x=v0t+1/2at^2ではなく前の位置を使用する(同じ意味ではある)
    }
    
}

struct ContentView: View {
    
    @ObservedObject var physicsManager = PhysicsManager()
    
    var body: some View {
        TimelineView(.periodic(from: Date(), by: physicsManager.frameRate)) { _ in
            
            VStack {
                
                Text("\(physicsManager.x)")
                
                ZStack {
                    Circle()
                        .position(CGPoint(x: 10, y: 200 + physicsManager.x))
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
