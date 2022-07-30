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
        let colors = UnitColors.offUnit
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
        let colors: UnitColors
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
        StartUnit(colors: .unit1,
                  icon: "drop.fill"),
        StartUnit(colors: .unit1,
                  icon: "flame.fill"),
        StartUnit(colors: .unit1,
                  icon: "bolt.fill")
    ]

    
    @State private var endUnitStates = [
        EndUnit(icon: "lightbulb.fill"),
        EndUnit(icon: "umbrella.fill"),
        EndUnit(icon: "macpro.gen3.fill")
    ]
    
    var attachedColor: Color {
        return .purple
    }
    
    var body: some View {
        
        ZStack {
            
            GeometryReader { geo in
                // TODO: Anchorの切り出し
                // positionは親ビューの相対位置であることに注意
                Circle()
                    .stroke(anchorState.colors.iconStroke, lineWidth: 4)
                    .background(Circle().foregroundColor(anchorState.colors.iconFill))
                    .frame(width: AnchorsState.anchorLength,
                           height: AnchorsState.anchorLength)
                    .position(CGPoint(
                        x: anchorState.startAnchorFrame.origin.x - geo.frame(in: .global).origin.x,
                        y: anchorState.startAnchorFrame.origin.y - geo.frame(in: .global).origin.y)
                    )
                    
                
                Circle()
                    .stroke(anchorState.colors.iconStroke, lineWidth: 4)
                    .background(Circle().foregroundColor(anchorState.colors.iconFill))
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
                RectangleUnitView(unitColors: .unit1,
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
                RectangleUnitView(unitColors: .offUnit,
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
