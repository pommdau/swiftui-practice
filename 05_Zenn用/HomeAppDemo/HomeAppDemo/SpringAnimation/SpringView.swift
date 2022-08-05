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
    
    @ObservedObject var pointsManager = PointsManager()
        
    // MARK: - View
    
    var body: some View {
        
        ZStack {
            ControlView()
                .offset(y: 100)
                .padding()
            
            TimelineView(.periodic(from: Date(), by: pointsManager.frameRate)) { context in
                ZStack {
                    Points()
                }
            }
        }
        .ignoresSafeArea()
        .background(.gray.opacity(0.5))
        .onAppear {
            pointsManager.startTimer()
        }
        .onDisappear {
            pointsManager.stopTimer()
        }
        .onTapGesture(coordinateSpace: .global) { location in
            pointsManager.point.vx = 0
            pointsManager.point.x = location.x
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
            .position(CGPoint(x: pointsManager.point.x,
                              y: pointsManager.standardPoint.y))
        Circle()
            .frame(width: pointRadius, height: pointRadius)
            .foregroundColor(.blue)
            .position(pointsManager.standardPoint)
    }
    
    @ViewBuilder
    private func ControlView() -> some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Stiffness(k): \(pointsManager.spring.k)")
                Slider(value: $pointsManager.spring.k,
                       in: -300...(-10),
                       step: 1,
                       minimumValueLabel: Text("-300"),
                       maximumValueLabel: Text("-10"),
                       label: { EmptyView() })
            }
            
            VStack(alignment: .leading) {
                Text("Mass(m): \(pointsManager.point.mass)")
                Slider(value: $pointsManager.point.mass,
                       in: 1...10,
                       step: 1,
                       minimumValueLabel: Text("1"),
                       maximumValueLabel: Text("10"),
                       label: { EmptyView() })
            }
            
            VStack(alignment: .leading) {
                Text("Dumping(d): \(pointsManager.spring.d)")
                Slider(value: $pointsManager.spring.d,
                       in: -5...0,
                       step: 0.1,
                       minimumValueLabel: Text("-5"),
                       maximumValueLabel: Text("0"),
                       label: { EmptyView() })
            }
        }
    }
}

struct SpringView_Previews: PreviewProvider {
    static var previews: some View {
        SpringView()
    }
}
