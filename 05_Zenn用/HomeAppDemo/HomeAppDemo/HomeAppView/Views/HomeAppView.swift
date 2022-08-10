//
//  HomeAppView.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/31.
//

import SwiftUI

struct HomeAppView: View {
    
    // MARK: - Properties
    
    @State private var colors: UnitColors = .offUnit
    
    @State private var marching = false
    private let lineWidth: CGFloat = 4
    private let dashPattern: [CGFloat] = [12, 14]
    private var physicsManager = PhysicsManager(pointP0: .init(x: 100, y: 100),
                                                pointP2: .init(x: 400, y: 100))
    
    @State private var anchor = Anchor()
    
    @State private var inputUnits = [
        Unit(colors: .unit1, icon: "drop.fill"),
        Unit(colors: .unit2, icon: "flame.fill"),
        Unit(colors: .unit3, icon: "bolt.fill")
    ]
    
    @State private var outputUnits = [
        Unit(colors: .offUnit, icon: "lightbulb.fill"),
        Unit(colors: .offUnit, icon: "umbrella.fill"),
        Unit(colors: .offUnit, icon: "macpro.gen3.fill")
    ]
    
    // MARK: - LifeCycle
    
    // MARK: - View
    var body: some View {
        
        TimelineView(.periodic(from: Date(), by: physicsManager.frameRate)) { context in
            ZStack {
                HStack(spacing: 140) {
                    InputUnitsView()
                    OutputUnitsView()
                }
                .offset(x: 0, y: -200)
                
                AnchorView(colors: colors)
                    .position(physicsManager.pointP2)
                AnchorView(colors: colors)
                    .position(physicsManager.pointP0)
                
                RopeView(pointP0: physicsManager.pointP0,
                         pointP1: physicsManager.anchor.point,
                         pointP2: physicsManager.pointP2,
                         colors: $colors)
            }
        }
        .ignoresSafeArea()
        .gesture(
            DragGesture(minimumDistance: 4, coordinateSpace: .global)
                .onChanged({ (value) in
                    
                    // アンカーの移動
                    switch anchor.draggingState {
                    case .none:
                        let inputAnchorFrame = CGRect(x: physicsManager.pointP0.x - AnchorView.radius / 2,
                                                      y: physicsManager.pointP0.y - AnchorView.radius / 2,
                                                      width: AnchorView.radius,
                                                      height: AnchorView.radius)
                        
                        let outputAnchorFrame = CGRect(x: physicsManager.pointP2.x - AnchorView.radius / 2,
                                                       y: physicsManager.pointP2.y - AnchorView.radius / 2,
                                                       width: AnchorView.radius,
                                                       height: AnchorView.radius)
                        
                        if inputAnchorFrame.contains(value.location) {
                            anchor.draggingState = .draggingInputAnchor
                        } else if outputAnchorFrame.contains(value.location) {
                            anchor.draggingState = .draggingOutputAnchor
                        }
                        
                    case .draggingInputAnchor:
                        physicsManager.pointP0 = value.location
                    case .draggingOutputAnchor:
                        physicsManager.pointP2 = value.location
                    }
                    
                    switch anchor.draggingState {
                    case .none:
                        break
                    case .draggingInputAnchor:  // InputUnitにつなぐかどうかの判定
                        if let match = inputUnits.firstIndex(where: { inputUnit in
                            return inputUnit.validFrame.contains(value.location)
                        }) {
                            anchor.connectedInputUnitIndex = match
                        } else {
                            deactivateInputUnits()
                        }
                    case .draggingOutputAnchor:  // OutputUnitにつなぐかどうかの判定
                        if let match = outputUnits.firstIndex(where: { outputUnit in
                            return outputUnit.validFrame.contains(value.location)
                        }) {
                            anchor.connectedOuputUnitIndex = match
                        } else {
                            deactivateOutputUnits()
                        }
                    }
                    
                    if anchor.isConnected {
                        withAnimation(.linear(duration: 0.5)) {
                            colors = inputUnits[anchor.connectedInputUnitIndex].colors
                            outputUnits[anchor.connectedOuputUnitIndex].colors = inputUnits[anchor.connectedInputUnitIndex].colors
                        }
                    } else {
                        colors = .offUnit
                        for i in outputUnits.indices {
                            outputUnits[i].colors = .offUnit
                        }
                    }
                    
                })
                .onEnded({ _ in
                    
                    switch anchor.draggingState {
                    case .none:
                        break
                    case .draggingInputAnchor:
                        let index = anchor.connectedInputUnitIndex
                        if index != -1 {
                            physicsManager.pointP0 = CGPoint(x: inputUnits[index].frame.midX,
                                                             y: inputUnits[index].frame.midY)
                        }
                    case .draggingOutputAnchor:
                        let index = anchor.connectedOuputUnitIndex
                        if index != -1 {
                            physicsManager.pointP2 =
                            CGPoint(x: outputUnits[index].frame.midX,
                                    y: outputUnits[index].frame.midY)
                        }
                    }
                    anchor.draggingState = .none
                })
        )
        .onAppear() {
            physicsManager.startTimer()
        }
    }
    
    private func deactivateInputUnits() {
        anchor.connectedInputUnitIndex = -1
    }
    
    private func deactivateOutputUnits() {
        anchor.connectedOuputUnitIndex = -1
    }
    
    // MARK: @ViewBuilder
    
    @ViewBuilder
    private func InputUnitsView() -> some View {
        VStack(spacing: 20) {
            ForEach(0 ..< outputUnits.count, id: \.self) { index in
                UnitView(icon: inputUnits[index].icon,
                         unitColors: $inputUnits[index].colors)
                .overlay(
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                inputUnits[index].frame = geo.frame(in: .global)
                            }
                    }
                )
            }
        }
    }
    
    @ViewBuilder
    private func OutputUnitsView() -> some View {
        VStack(spacing: 20) {
            ForEach(0 ..< outputUnits.count, id: \.self) { index in
                UnitView(
                    icon: outputUnits[index].icon,
                    unitColors: $outputUnits[index].colors)
                .overlay(
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                outputUnits[index].frame = geo.frame(in: .global)
                            }
                    }
                )
            }
        }
    }
    
}


struct RopeView_Previews: PreviewProvider {    
    
    static var previews: some View {
        HomeAppView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
