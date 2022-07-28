//
//  HomeAppView.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/27.
//

import SwiftUI


struct HomeAppView: View {
    @State private var rectangleUnitFrames = [CGRect]()
    @State private var rectangleUnitStates = [false]
    
    var body: some View {
        HStack(spacing: 20) {
//            Toggle(isOn: $isActive.animation()) {}
            RectangleUnitView(color: .blue, active: $rectangleUnitStates[0])
                .overlay(
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                rectangleUnitFrames.insert(
                                    (geo.frame(in: .global)), at: 0
                                )
                            }
                    }
                )
        }
        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged({ (value) in
                if let match = rectangleUnitFrames.firstIndex(where: { $0.contains(value.location) }) {
                    rectangleUnitStates[match] = true
                } else {
                    deactivateSounds()
                }
            })
                .onEnded({ (_) in
                    deactivateSounds()
                })
        )
    }
    
    private func deactivateSounds() {
        for index in rectangleUnitStates.indices {
            rectangleUnitStates[index] = false
        }
    }
    
}

struct HomeAppView_Previews: PreviewProvider {
    static var previews: some View {
        HomeAppView()
    }
}
