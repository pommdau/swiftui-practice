//
//  HomeAppView.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/27.
//

import SwiftUI




struct HomeAppView: View {
    
    enum DraggingStates {
        case none
        case draggingAnchor1
        case draggingAnchor2
    }
    
    @State private var anchorFrames: [CGRect] = [
        CGRect(x: 100, y: 100, width: 60, height: 60),
        CGRect(x: 100, y: 200, width: 60, height: 60),
    ]
    @State private var draggingStates: DraggingStates = .none
    @State private var rectangleUnitFrames = [CGRect]()
    @State private var rectangleUnitStates = [false]
    
    var body: some View {
                 
        ZStack {
            GeometryReader { geo in
                // positionは親ビューの相対位置であることに注意
                Circle()
                    .frame(width: 60, height: 60)
                    .position(CGPoint(
                        x: anchorFrames[0].origin.x - geo.frame(in: .global).origin.x,
                        y: anchorFrames[0].origin.y - geo.frame(in: .global).origin.y)
                    )
                    .foregroundColor(.orange)
            }
            .zIndex(1)
            HStack(spacing: 20) {
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
                
                // Anchorのドラッグ確認
//                anchorFrames[0].origin = value.location
                
                switch draggingStates {
                case .none:
                    if let match = anchorFrames.firstIndex(where: { frame in
                        return frame.contains(value.location)
                    }) {
                        draggingStates = .draggingAnchor1
                    } else {

                    }
                case .draggingAnchor1:
                    anchorFrames[0].origin = value.location
                case .draggingAnchor2:
                    break
                }

                if let match = rectangleUnitFrames.firstIndex(where: { frame in
                    let length: CGFloat = 40  // ニコちゃんマークの大きさと一致させる
                    let validFrame = CGRect(origin: CGPoint(x: frame.midX - length / 2,
                                                            y: frame.midY - length / 2),
                                            size: CGSize(width: length, height: length))
                    return validFrame.contains(value.location)
                }) {
                    rectangleUnitStates[match] = true
                    anchorFrames[0].origin = CGPoint(x: rectangleUnitFrames[match].midX,
                                                     y: rectangleUnitFrames[match].midY)
                    
                } else {
                    deactivateSounds()
                }                
            })
                .onEnded({ (_) in
                    deactivateSounds()
                    draggingStates = .none
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
