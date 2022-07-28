//
//  HomeAppView.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/27.
//

import SwiftUI


struct HomeAppView: View {
    
    enum StartAnchorState {
        case none
        case attachedToUnit1
        case attachedToUnit2
        case attachedToUnit3
    }
    
    enum EndAnchorState {
        case none
        case attachedToUnit1
        case attachedToUnit2
        case attachedToUnit3
    }
    
    enum DraggingStates {
        case none
        case draggingAnchor1
        case draggingAnchor2
    }
    
    @State private var startAnchorState: StartAnchorState = .attachedToUnit1
    
    @State private var anchorFrames: [CGRect] = [
        CGRect(x: 100, y: 100, width: 60, height: 60),
        CGRect(x: 100, y: 200, width: 60, height: 60),
    ]
    @State private var draggingStates: DraggingStates = .none
    
    @State private var endUnitFrames = [CGRect]()
    @State private var endUnitStates = [false, false, false]
    
    var attachedColor: Color {
        // TODO: anchorの状態を反映させる
        switch startAnchorState {
        case .none:
            return .gray
        case .attachedToUnit1:
            return .blue
        case .attachedToUnit2:
            return .yellow
        case .attachedToUnit3:
            return .red
        }
    }
    
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
            VStack(spacing: 20) {
                RectangleUnitView(color: attachedColor, active: $endUnitStates[0])
                    .overlay(
                        GeometryReader { geo in
                            Color.clear
                                .onAppear {
                                    endUnitFrames.insert(
                                        (geo.frame(in: .global)), at: 0
                                    )
                                }
                        }
                    )
                
                RectangleUnitView(color: attachedColor, active: $endUnitStates[1])
                    .overlay(
                        GeometryReader { geo in
                            Color.clear
                                .onAppear {
                                    endUnitFrames.insert(
                                        (geo.frame(in: .global)), at: 0
                                    )
                                }
                        }
                    )
                
                RectangleUnitView(color: attachedColor
                                  , active: $endUnitStates[2])
                    .overlay(
                        GeometryReader { geo in
                            Color.clear
                                .onAppear {
                                    endUnitFrames.insert(
                                        (geo.frame(in: .global)), at: 0
                                    )
                                }
                        }
                    )
            }
        }
        .gesture(DragGesture(minimumDistance: 4, coordinateSpace: .global)
            .onChanged({ (value) in
                                                                            
                // Anchorのドラッグ処理
                switch draggingStates {
                case .none:
                    if anchorFrames[0].contains(value.location) {
                        draggingStates = .draggingAnchor1
                    } else if anchorFrames[1].contains(value.location) {
                        draggingStates = .draggingAnchor2
                    }
                case .draggingAnchor1:
                    anchorFrames[0].origin = value.location
                case .draggingAnchor2:
                    break
                }
                
                // Unitにつなぐかどうかの判定
                if let match = endUnitFrames.firstIndex(where: { frame in
                    let length: CGFloat = 40  // 当たり判定: ニコちゃんマークの大きさ
                    let validFrame = CGRect(origin: CGPoint(x: frame.midX - length / 2,
                                                            y: frame.midY - length / 2),
                                            size: CGSize(width: length, height: length))
                    return validFrame.contains(value.location)
                }) {
                    endUnitStates[match] = true
                    anchorFrames[0].origin = CGPoint(x: endUnitFrames[match].midX,
                                                     y: endUnitFrames[match].midY)
                    
                } else {
                    deactivateSounds()
                }                
            })
                .onEnded({ (_) in
                                        
//                    deactivateSounds()
                    draggingStates = .none
                })
        )
    }
    
    private func deactivateSounds() {
        for index in endUnitStates.indices {
            endUnitStates[index] = false
        }
    }
    
}

struct HomeAppView_Previews: PreviewProvider {
    static var previews: some View {
        HomeAppView()
    }
}
