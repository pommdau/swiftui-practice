//
//  SpringView.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/08/05.
//

import SwiftUI

struct SpringView: View {
    
    // MARK: - Properties
    
    // MARK: Private Properties
    
    private let pointRadius: CGFloat = 20
    
    // MARK: Public Properties
    
    @ObservedObject var physicsManager = PhysicsManager()
        
    // MARK: - View
    
    var body: some View {
        
        TimelineView(.periodic(from: Date(), by: physicsManager.frameRate)) { context in
            ZStack {
                Points()
            }
        }
        .ignoresSafeArea()
        .background(.gray.opacity(0.5))
        .onAppear {
            physicsManager.startTimer()
        }
        .onTapGesture(coordinateSpace: .global) { location in
            physicsManager.point.vx = 0
            physicsManager.point.x = location.x
        }
        .gesture(
            DragGesture(minimumDistance: 4, coordinateSpace: .global)
                .onChanged({ (value) in
                    print(value)
                })
        )
    }
    
    @ViewBuilder
    private func Points() -> some View {
        Circle()
            .frame(width: pointRadius, height: pointRadius)
            .foregroundColor(.red)
            .position(CGPoint(x: physicsManager.point.x,
                              y: physicsManager.standardPoint.y))
        Circle()
            .frame(width: pointRadius, height: pointRadius)
            .foregroundColor(.blue)
            .position(physicsManager.standardPoint)
    }
}

struct SpringView_Previews: PreviewProvider {
    static var previews: some View {
        SpringView()
    }
}
