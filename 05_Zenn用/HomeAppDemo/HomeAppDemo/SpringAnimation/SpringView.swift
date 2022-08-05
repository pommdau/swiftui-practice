//
//  SpringView.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/08/05.
//

import SwiftUI

struct SpringView: View {
    
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
                            .position(CGPoint(x: standardPoint.x + physicsManager.point.x,
                                              y: standardPoint.y))
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
        .onTapGesture(coordinateSpace: .local) { location in
            physicsManager.point.x = location.x
            physicsManager.point.vx = 0
        }
    }
}

struct SpringView_Previews: PreviewProvider {
    static var previews: some View {
        SpringView()
    }
}

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
//            let fDampingX = spring.d * point.vx
//            let ax = (fSpringX + fDampingX) / point.mass  // 加速度
            
            let ax = fSpringX / point.mass
            
            point.vx = point.vx + ax * frameRate
            point.x = point.x + point.vx * frameRate
        }
        
    }
}
