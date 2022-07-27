//
//  ContentView.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/26.
//

import SwiftUI

struct Point {
    let mass: Double = 1  // 質量
    var y: Double = 100
    var v: Double = 0
}

struct Spring {
    let springLength: Double = 0
    var k: Double = -200  // stiffness: 20
    let d = -2.0  // damping: 減衰振動
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
        let fSpring = spring.k * (point.y - spring.springLength)  // フックの法則
        let fDamping = spring.d * point.v
        let a = (fSpring + fDamping) / point.mass  // 加速度
        point.v = point.v + a * frameRate
        point.y = point.y + point.v * frameRate  // x=v0t+1/2at^2ではなく前の位置を使用する(同じ意味ではある)
    }
    
}

struct ContentView: View {
    
    @ObservedObject var physicsManager = PhysicsManager()
    private let standardPoint = CGPoint(x: 200, y: 400)
    
    var body: some View {
        
        ZStack {
            Color.yellow
                .contentShape(Rectangle())
                .ignoresSafeArea()
            
            TimelineView(.periodic(from: Date(), by: physicsManager.frameRate)) { _ in
                VStack {
//                    Text("\(physicsManager.point.y)")
                    ZStack {
                        Circle()
                            .position(CGPoint(x: standardPoint.x,
                                              y: standardPoint.y + physicsManager.point.y))
                            .frame(width: 30, height: 30)
                            .foregroundColor(.red)
                        Circle()
                            .position(standardPoint)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.blue)
                    }
                }
            }
            .position(x: 0, y: 0)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.green)
        }
        .onAppear {
            physicsManager.startTimer()
        }
        .onTouch(type: .started, limitToBounds: true, perform: { location in
//            physicsManager.point.y = 200 - location.y
            physicsManager.point.y = location.y - standardPoint.y
            physicsManager.point.v = 0
//            print(location.y - 200)
//            print(location.y)
        })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
