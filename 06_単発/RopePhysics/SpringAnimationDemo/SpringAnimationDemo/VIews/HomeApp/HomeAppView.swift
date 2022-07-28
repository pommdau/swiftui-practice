//
//  HomeAppView.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/27.
//

import SwiftUI


struct HomeAppView: View {
    
    @State private var anchorFrames: [CGRect] = [CGRect(x: 100, y: 100, width: 100, height: 100)]
    @State private var rectangleUnitFrames = [CGRect]()
    @State private var rectangleUnitStates = [false]
    
    var body: some View {
                 
        ZStack {
            GeometryReader { geo in
                Circle()
                    .frame(width: 20, height: 20)
                    .position(CGPoint(
                        x: anchorFrames[0].origin.x - geo.frame(in: .global).origin.x,
                        y: anchorFrames[0].origin.y - geo.frame(in: .global).origin.y)
                    )
                    .foregroundColor(.orange)
            }
            
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
        }
        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged({ (value) in
                anchorFrames[0].origin = value.location                
                if let match = rectangleUnitFrames.firstIndex(where: { frame in
                    let length: CGFloat = 40  // ニコちゃんマークの大きさと一致させる
                    let validFrame = CGRect(origin: CGPoint(x: frame.midX - length / 2,
                                                            y: frame.midY - length / 2),
                                            size: CGSize(width: length, height: length))
                    return validFrame.contains(value.location)
                }) {
                    rectangleUnitStates[match] = true
                } else {
                    deactivateSounds()
                }                
            })
                .onEnded({ (_) in
                    deactivateSounds()
                    print(rectangleUnitFrames[0])
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
