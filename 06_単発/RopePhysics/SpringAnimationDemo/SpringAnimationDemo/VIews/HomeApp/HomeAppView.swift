//
//  HomeAppView.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/27.
//

import SwiftUI


struct HomeAppView: View {
            
    struct AnchorsState {
        
        enum DraggingStates {
            case none
            case draggingStartAnchor
            case draggingEndAnchor
        }
        
        let id = UUID().uuidString
        var draggingStates: DraggingStates = .none
        var startAnchorAttachedIndex = -1
        var endAnchorAttachedIndex = -1
        var startAnchorFrame: CGRect = CGRect(x: 100, y: 100, width: 60, height: 60)
        var endAnchorFrame: CGRect = CGRect(x: 200, y: 200, width: 60, height: 60)
        
        var isConnected: Bool {
            return startAnchorAttachedIndex >= 0 && endAnchorAttachedIndex >= 0
        }
    }
    
    // TODO: UnitStateのマージ
    struct StartUnitState {
        let id = UUID().uuidString
        var frame: CGRect = .zero
        var color: Color  // ONになったときの色
        var isAttached: Bool = false
        var validFrame: CGRect {
            let length: CGFloat = 40  // 当たり判定: ニコちゃんマークの大きさ
            let validFrame = CGRect(origin: CGPoint(x: frame.midX - length / 2,
                                                    y: frame.midY - length / 2),
                                    size: CGSize(width: length, height: length))
            return validFrame
        }
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
    @State private var startUnitStates = [StartUnitState(color: .red),
                                          StartUnitState(color: .blue),
                                          StartUnitState(color: .yellow)]
    @State private var endUnitStates = [EndUnitState(),
                                        EndUnitState(),
                                        EndUnitState()]
    
    var attachedColor: Color {
        let startUnitIndex = anchorState.startAnchorAttachedIndex
        switch startUnitIndex {
        case 0, 1, 2:
            return startUnitStates[startUnitIndex].color
        default:
            return .clear
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
            
            HStack(spacing: 140) {
                StartUnitsView()
                EndUnitsView()
            }
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
                                
                switch anchorState.draggingStates {
                case .none:
                    break
                case .draggingStartAnchor:  // StartUnitにつなぐかどうかの判定
                    if let match = startUnitStates.firstIndex(where: { startUnitState in
                        return startUnitState.validFrame.contains(value.location)
                    }) {
                        anchorState.startAnchorAttachedIndex = match
                        anchorState.startAnchorFrame.origin = CGPoint(x: startUnitStates[match].frame.midX,
                                                                    y: startUnitStates[match].frame.midY)
                        startUnitStates[match].isAttached = true
                    } else {
                        deactivateStartUnits()
                    }
                
                case .draggingEndAnchor:  // EndUnitにつなぐかどうかの判定
                    if let match = endUnitStates.firstIndex(where: { endUnitState in
                        return endUnitState.validFrame.contains(value.location)
                    }) {
                        anchorState.endAnchorAttachedIndex = match
                        anchorState.endAnchorFrame.origin = CGPoint(x: endUnitStates[match].frame.midX,
                                                                    y: endUnitStates[match].frame.midY)
                        endUnitStates[match].isAttached = true
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
    
    private func deactivateStartUnits() {
        anchorState.startAnchorAttachedIndex = -1
        for index in startUnitStates.indices {
            startUnitStates[index].isAttached = false
        }

    }
    
    private func deactivateEndUnits() {
        anchorState.endAnchorAttachedIndex = -1
        for index in startUnitStates.indices {
            endUnitStates[index].isAttached = false
        }
    }
    
    @ViewBuilder
    private func StartUnitsView() -> some View {
        VStack(spacing: 20) {
            ForEach(0 ..< endUnitStates.count, id: \.self) { index in
                RectangleUnitView(color: attachedColor,
                                  active: anchorState.isConnected && startUnitStates[index].isAttached)
                    .overlay(
                        GeometryReader { geo in
                            Color.clear
                                .onAppear {
                                    startUnitStates[index].frame = geo.frame(in: .global)
                                }
                        }
                    )
            }
        }
    }
    
    @ViewBuilder
    private func EndUnitsView() -> some View {
        VStack(spacing: 20) {
            ForEach(0 ..< endUnitStates.count, id: \.self) { index in
                RectangleUnitView(color: attachedColor,
                                  active: anchorState.isConnected && endUnitStates[index].isAttached)
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
