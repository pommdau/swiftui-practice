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
        case draggingStartAnchor
        case draggingEndAnchor
    }
    
    struct EndUnitState {
        let id = UUID().uuidString
        var frame: CGRect = .zero
        var isAttached: Bool = false
        
        var validFrame: CGRect {
            let length: CGFloat = 40  // 当たり判定: ニコちゃんマークの大きさ
            let validFrame = CGRect(origin: CGPoint(x: frame.midX - length / 2,
                                                    y: frame.midY - length / 2),
                                    size: CGSize(width: length, height: length))
            return validFrame
        }
    }
    
    @State private var startAnchorState: StartAnchorState = .attachedToUnit1
    @State private var anchorFrames: [CGRect] = [
        CGRect(x: 100, y: 100, width: 60, height: 60),
        CGRect(x: 100, y: 200, width: 60, height: 60),
    ]
    @State private var draggingStates: DraggingStates = .none
    @State private var endUnitStates = [EndUnitState(), EndUnitState(), EndUnitState()]
    
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
            EndUnitsView()
        }
        .gesture(DragGesture(minimumDistance: 4, coordinateSpace: .global)
            .onChanged({ (value) in
                
                // Anchorのドラッグ処理
                switch draggingStates {
                case .none:
                    if anchorFrames[0].contains(value.location) {
                        draggingStates = .draggingStartAnchor
                    } else if anchorFrames[1].contains(value.location) {
                        draggingStates = .draggingEndAnchor
                    }
                case .draggingStartAnchor:
                    anchorFrames[0].origin = value.location
                case .draggingEndAnchor:
                    break
                }
                
                // Unitにつなぐかどうかの判定
                if let match = endUnitStates.firstIndex(where: { endUnitState in
                    return endUnitState.validFrame.contains(value.location)
                }) {
                    endUnitStates[match].isAttached = true
                    anchorFrames[0].origin = CGPoint(x: endUnitStates[match].frame.midX,
                                                     y: endUnitStates[match].frame.midY)
                } else {
                    deactivateEndUnits()
                }
            })
                .onEnded({ (_) in
                    draggingStates = .none
                })
        )
    }
    
    private func deactivateEndUnits() {
        for index in endUnitStates.indices {
            endUnitStates[index].isAttached = false
        }
    }
    
    @ViewBuilder
    private func EndUnitsView() -> some View {
        VStack(spacing: 20) {
            ForEach(0 ..< endUnitStates.count, id: \.self) { index in
                RectangleUnitView(color: attachedColor, active: $endUnitStates[index].isAttached)
                    .overlay(
                        GeometryReader { geo in
                            Color.clear
                                .onAppear {
                                    endUnitStates[index].frame = geo.frame(in: .global)
                                }
                        }
                    )
            }
        }
    }
    
}


struct HomeAppView_Previews: PreviewProvider {
    static var previews: some View {
        HomeAppView()
        //        EndUnitsView(attachedColor: .constant(.blue))
    }
}
