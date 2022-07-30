//
//  HomeAppView.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/27.
//

import SwiftUI

struct HomeAppView: View {
            
    struct AnchorManager {
                
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
        var icon: String
        var validFrame: CGRect {
            let length: CGFloat = 40  // 当たり判定: ニコちゃんマークの大きさ
            let validFrame = CGRect(origin: CGPoint(x: frame.midX - length / 2,
                                                    y: frame.midY - length / 2),
                                    size: CGSize(width: length, height: length))
            return validFrame
        }
    }
    
    @State private var anchorManager = AnchorManager()
    
    @State private var startUnits = [
        StartUnit(colors: .unit1,
                  icon: "drop.fill"),
        StartUnit(colors: .unit2,
                  icon: "flame.fill"),
        StartUnit(colors: .unit3,
                  icon: "bolt.fill")
    ]
    
    @State private var endUnits = [
        EndUnit(icon: "lightbulb.fill"),
        EndUnit(icon: "umbrella.fill"),
        EndUnit(icon: "macpro.gen3.fill")
    ]
    
    var currentUnitColors: UnitColors {
        guard anchorManager.isConnected else {
            return .offUnit
        }
        
        switch anchorManager.attachedStartUnitIndex {
        case 0:
            return .unit1
        case 1:
            return .unit2
        case 2:
            return .unit3
        default:
            return .offUnit
        }
        
    }
    
    var body: some View {
        
        ZStack {
            GeometryReader { geo in
                // TODO: Anchorの切り出し
                // positionは親ビューの相対位置であることに注意
                AnchorView(colors: .offUnit)
                    .position(CGPoint(
                        x: anchorManager.startAnchorFrame.origin.x - geo.frame(in: .global).origin.x,
                        y: anchorManager.startAnchorFrame.origin.y - geo.frame(in: .global).origin.y)
                    )
                                    
                AnchorView(colors: .offUnit)
                    .position(CGPoint(
                        x: anchorManager.endAnchorFrame.origin.x - geo.frame(in: .global).origin.x,
                        y: anchorManager.endAnchorFrame.origin.y - geo.frame(in: .global).origin.y)
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
                switch anchorManager.draggingState {
                case .none:
                    if anchorManager.startAnchorFrame.contains(value.location) {
                        anchorManager.draggingState = .draggingStartAnchor
                    } else if anchorManager.endAnchorFrame.contains(value.location) {
                        anchorManager.draggingState = .draggingEndAnchor
                    }
                case .draggingStartAnchor:
                    anchorManager.startAnchorFrame.origin = value.location
                case .draggingEndAnchor:
                    anchorManager.endAnchorFrame.origin = value.location
                }
                                
                switch anchorManager.draggingState {
                case .none:
                    break
                case .draggingStartAnchor:  // StartUnitにつなぐかどうかの判定
                    if let match = startUnits.firstIndex(where: { startUnitState in
                        return startUnitState.validFrame.contains(value.location)
                    }) {
                        anchorManager.attachedStartUnitIndex = match
                        anchorManager.startAnchorFrame.origin =
                        CGPoint(x: startUnits[match].frame.midX,
                                y: startUnits[match].frame.midY)
                    } else {
                        deactivateStartUnits()
                    }
                
                case .draggingEndAnchor:  // EndUnitにつなぐかどうかの判定
                    if let match = endUnits.firstIndex(where: { endUnitState in
                        return endUnitState.validFrame.contains(value.location)
                    }) {
                        anchorManager.attachedEndUnitIndex = match
                        anchorManager.endAnchorFrame.origin =
                        CGPoint(x: endUnits[match].frame.midX,
                                y: endUnits[match].frame.midY)
                    } else {
                        deactivateEndUnits()
                    }
                }
            })
                .onEnded({ (_) in
                    anchorManager.draggingState = .none
                })
        )
    }
    
    private func deactivateStartUnits() {
        anchorManager.attachedStartUnitIndex = -1
    }
    
    private func deactivateEndUnits() {
        anchorManager.attachedEndUnitIndex = -1
    }
        
    @ViewBuilder
    private func StartUnitsView() -> some View {
        VStack(spacing: 20) {
            ForEach(0 ..< endUnits.count, id: \.self) { index in
                UnitView(unitColors: startUnits[index].colors,
                                  icon: startUnits[index].icon)
                    .overlay(
                        GeometryReader { geo in
                            Color.clear
                                .onAppear {
                                    startUnits[index].frame = geo.frame(in: .global)
                                }
                        }
                    )
            }
        }
    }
    
    @ViewBuilder
    private func EndUnitsView() -> some View {
        VStack(spacing: 20) {
            ForEach(0 ..< endUnits.count, id: \.self) { index in
                UnitView(unitColors: index == anchorManager.attachedEndUnitIndex ? currentUnitColors : .offUnit,
                                  icon: endUnits[index].icon)
                    .overlay(
                        GeometryReader { geo in
                            Color.clear
                                .onAppear {
                                    endUnits[index].frame = geo.frame(in: .global)
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
