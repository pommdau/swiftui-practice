//
//  HomeAppView.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/27.
//

import SwiftUI


struct HomeAppView: View {
            
    struct AnchorsState {
        
        static let anchorLength: CGFloat = 44
        
        enum DraggingState {
            case none
            case draggingStartAnchor
            case draggingEndAnchor
        }
        
        let id = UUID().uuidString
        var fillColor: Color = .fillAnchor
        var strokeColor: Color = .strokeAnchor
        
        var draggingState: DraggingState = .none
        var startAnchorFrame: CGRect = CGRect(x: 100, y: 100, width: 60, height: 60)
        var endAnchorFrame: CGRect = CGRect(x: 200, y: 200, width: 60, height: 60)
        var attachedStartUnitIndex = -1
        var attachedEndUnitIndex = -1
        
        var isConnected: Bool {
            return attachedStartUnitIndex >= 0 && attachedEndUnitIndex >= 0
        }
    }
    
    // TODO: UnitStateのマージ
    struct StartUnit {
        let id = UUID().uuidString
        var frame: CGRect = .zero
        let unitColor: UnitColor
        let icon: String
        
        var validFrame: CGRect {
            let length: CGFloat = 40  // 当たり判定: ニコちゃんマークの大きさ
            let validFrame = CGRect(origin: CGPoint(x: frame.midX - length / 2,
                                                    y: frame.midY - length / 2),
                                    size: CGSize(width: length, height: length))
            return validFrame
        }
    }
    
    struct EndUnit {
        let id = UUID().uuidString
        var frame: CGRect = .zero
        var isGrowing: Bool = false
        
        var fillColor: Color
        var strokeColor: Color
        var icon: String
                
        var validFrame: CGRect {
            let length: CGFloat = 40  // 当たり判定: ニコちゃんマークの大きさ
            let validFrame = CGRect(origin: CGPoint(x: frame.midX - length / 2,
                                                    y: frame.midY - length / 2),
                                    size: CGSize(width: length, height: length))
            return validFrame
        }
    }
    
    @State private var anchorState = AnchorsState()
    @State private var startUnitStates = [
        StartUnit(unitColor: .unit1,
                  icon: "drop.fill"),
        StartUnit(unitColor: .unit1,
                  icon: "flame.fill"),
        StartUnit(unitColor: .unit1,
                  icon: "bolt.fill")
    ]

    
    @State private var endUnitStates = [
        EndUnit(fillColor: .fillUnit1,
                strokeColor: .strokeUnit1,
                icon: "lightbulb.fill"),
        EndUnit(fillColor: .fillUnit2,
                strokeColor: .strokeUnit2,
                icon: "umbrella.fill"),
        EndUnit(fillColor: .fillUnit3,
                strokeColor: .strokeUnit3,
                icon: "macpro.gen3.fill"),
    ]
    
    var attachedColor: Color {
        return .purple
    }
    
    var body: some View {
        
        ZStack {
            
            GeometryReader { geo in
                // positionは親ビューの相対位置であることに注意
                Circle()
                    .stroke(anchorState.strokeColor, lineWidth: 4)
                    .background(Circle().foregroundColor(anchorState.fillColor))
                    .frame(width: AnchorsState.anchorLength,
                           height: AnchorsState.anchorLength)
                    .position(CGPoint(
                        x: anchorState.startAnchorFrame.origin.x - geo.frame(in: .global).origin.x,
                        y: anchorState.startAnchorFrame.origin.y - geo.frame(in: .global).origin.y)
                    )
                    
                
                Circle()
                    .stroke(anchorState.strokeColor, lineWidth: 4)
                    .background(Circle().foregroundColor(anchorState.fillColor))
                    .frame(width: AnchorsState.anchorLength,
                           height: AnchorsState.anchorLength)
                    .position(CGPoint(
                        x: anchorState.endAnchorFrame.origin.x - geo.frame(in: .global).origin.x,
                        y: anchorState.endAnchorFrame.origin.y - geo.frame(in: .global).origin.y)
                    )
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
                switch anchorState.draggingState {
                case .none:
                    if anchorState.startAnchorFrame.contains(value.location) {
                        anchorState.draggingState = .draggingStartAnchor
                    } else if anchorState.endAnchorFrame.contains(value.location) {
                        anchorState.draggingState = .draggingEndAnchor
                    }
                case .draggingStartAnchor:
                    anchorState.startAnchorFrame.origin = value.location
                case .draggingEndAnchor:
                    anchorState.endAnchorFrame.origin = value.location
                }
                                
                switch anchorState.draggingState {
                case .none:
                    break
                case .draggingStartAnchor:  // StartUnitにつなぐかどうかの判定
                    if let match = startUnitStates.firstIndex(where: { startUnitState in
                        return startUnitState.validFrame.contains(value.location)
                    }) {
                        anchorState.attachedStartUnitIndex = match
                        anchorState.startAnchorFrame.origin =
                        CGPoint(x: startUnitStates[match].frame.midX,
                                y: startUnitStates[match].frame.midY)
                    } else {
                        deactivateStartUnits()
                    }
                
                case .draggingEndAnchor:  // EndUnitにつなぐかどうかの判定
                    if let match = endUnitStates.firstIndex(where: { endUnitState in
                        return endUnitState.validFrame.contains(value.location)
                    }) {
                        anchorState.attachedEndUnitIndex = match
                        anchorState.endAnchorFrame.origin =
                        CGPoint(x: endUnitStates[match].frame.midX,
                                y: endUnitStates[match].frame.midY)
                    } else {
                        deactivateEndUnits()
                    }
                }
            })
                .onEnded({ (_) in
                    anchorState.draggingState = .none
                })
        )
    }
    
    private func deactivateStartUnits() {
        anchorState.attachedStartUnitIndex = -1
    }
    
    private func deactivateEndUnits() {
        anchorState.attachedEndUnitIndex = -1
    }
    
    @ViewBuilder
    private func StartUnitsView() -> some View {
        VStack(spacing: 20) {
            ForEach(0 ..< endUnitStates.count, id: \.self) { index in
                RectangleUnitView(color: startUnitStates[index].unitColor.frameFill,
                                  active: true,
                                  icon: startUnitStates[index].icon)
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
                                  active: anchorState.isConnected,
                                  icon: endUnitStates[index].icon)
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
