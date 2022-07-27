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
    let springLength: Double = 10
    var x: Double = 100
    var v: Double = 0
    var k: Double = -20  // stiffness: 20
//    var frameRate = 1 / 60
    var frameRate: Double = 1 / 60
    var positions = [CGFloat]()
    
    private func updateStatus() {
        let fSpring = k * (x - springLength)  // フックの法則
        let a = fSpring / mass  // 加速度
        v = v + a * frameRate
        x = x + v * frameRate  // x=v0t+1/2at^2じゃない？
    }
        
}

struct ContentView: View {
        
//    private let standardHeight: CGFloat = 400
//    @State private var yOffset: CGFloat = 10
    
    @ObservedObject var physicsManager = PhysicsManager()
    
    var body: some View {
        TimelineView(.periodic(from: Date(), by: physicsManager.frameRate)) { _ in
            Circle()
                .position(CGPoint(x: 100 + physicsManager.x, y: 200))
                .frame(width: 30, height: 30)
                .foregroundColor(.red)
        }
        
//        GeometryReader { geometry in
//            TimelineView(.periodic(from: Date(), by: 1)) { context in
//                VStack {
//                    Text("\(context.date)")
//                    Circle()
//                        .frame(width: 30, height: 30)
//                        .position(CGPoint(x: geometry.size.width / 2,
//                                          y: geometry.size.height / 2 + yOffset))
//                        .foregroundColor(.red)
//
//                }
//            }
//        }
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
