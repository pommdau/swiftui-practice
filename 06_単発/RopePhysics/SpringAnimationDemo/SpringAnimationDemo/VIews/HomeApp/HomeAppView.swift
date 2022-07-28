//
//  HomeAppView.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/27.
//

import SwiftUI


struct HomeAppView: View {
            
    struct AnchorsState {
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
        
        let id = UUID().uuidString
        var draggingStates: DraggingStates = .none
        var startAnchorState: StartAnchorState = .none
        var endAnchorState: EndAnchorState = .none
        var startAnchorFrame: CGRect = CGRect(x: 100, y: 100, width: 60, height: 60)
        var endAnchorFrame: CGRect = CGRect(x: 200, y: 200, width: 60, height: 60)
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
    
    @State private var anchorState = AnchorsState()
    @State private var endUnitStates = [EndUnitState(), EndUnitState(), EndUnitState()]
    
    var attachedColor: Color {
        // TODO: anchorの状態を反映させる
        switch anchorState.startAnchorState {
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
                        x: anchorState.startAnchorFrame.origin.x - geo.frame(in: .global).origin.x,
                        y: anchorState.startAnchorFrame.origin.y - geo.frame(in: .global).origin.y)
                    )
                    .foregroundColor(.black)
                
                Circle()
                    .frame(width: 60, height: 60)
                    .position(CGPoint(
                        x: anchorState.endAnchorFrame.origin.x - geo.frame(in: .global).origin.x,
                        y: anchorState.endAnchorFrame.origin.y - geo.frame(in: .global).origin.y)
                    )
                    .foregroundColor(.orange)
            }
            .zIndex(1)
            EndUnitsView()
        }
        .gesture(DragGesture(minimumDistance: 4, coordinateSpace: .global)
            .onChanged({ (value) in
                
                // Anchorのドラッグ処理
                switch anchorState.draggingStates {
                case .none:
                    if anchorState.startAnchorFrame.contains(value.location) {
                        anchorState.draggingStates = .draggingStartAnchor
                    } else if anchorState.endAnchorFrame.contains(value.location) {
                        anchorState.draggingStates = .draggingEndAnchor
                    }
                case .draggingStartAnchor:
                    anchorState.startAnchorFrame.origin = value.location
                case .draggingEndAnchor:
                    anchorState.endAnchorFrame.origin = value.location
                }
                
                // EndUnitにつなぐかどうかの判定
                
                switch anchorState.draggingStates {
                    
                case .none:
                    break
                case .draggingStartAnchor:
                    break
                case .draggingEndAnchor:
                    if let match = endUnitStates.firstIndex(where: { endUnitState in
                        return endUnitState.validFrame.contains(value.location)
                    }) {
                        endUnitStates[match].isAttached = true
                        anchorState.endAnchorFrame.origin = CGPoint(x: endUnitStates[match].frame.midX,
                                                                    y: endUnitStates[match].frame.midY)
                    } else {
                        deactivateEndUnits()
                    }
                }                                
            })
                .onEnded({ (_) in
                    anchorState.draggingStates = .none
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
