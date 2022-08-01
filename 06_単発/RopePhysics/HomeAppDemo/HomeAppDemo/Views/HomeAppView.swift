//
//  HomeAppView.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/31.
//

import SwiftUI

struct HomeAppView: View {
    
    // MARK: - Properties
    
    @State private var colors: UnitColors = .unit3
    @State private var isGlowing: Bool = true
    @State private var marching = false
    private let lineWidth: CGFloat = 4
    private let dashPattern: [CGFloat] = [12, 14]
    private var physicsManager = PhysicsManager(pointP0: .init(x: 100, y: 100),
                                                pointP2: .init(x: 400, y: 100))
    
    @State private var startUnits = [
        StartUnit(colors: .unit1, icon: "drop.fill"),
        StartUnit(colors: .unit2, icon: "flame.fill"),
        StartUnit(colors: .unit3, icon: "bolt.fill")
    ]
    
    @State private var endUnits = [
        EndUnit(icon: "lightbulb.fill"),
        EndUnit(icon: "umbrella.fill"),
        EndUnit(icon: "macpro.gen3.fill")
    ]
    
    // MARK: - LifeCycle
    
    // MARK: - View
    var body: some View {
        
        TimelineView(.periodic(from: Date(), by: physicsManager.frameRate)) { context in
            ZStack {
                HStack(spacing: 200) {
                    StartUnitsView()
                    EndUnitsView()
                }
                
                AnchorView(colors: isGlowing ? colors : .offUnit)
                    .position(physicsManager.pointP0)
                AnchorView(colors: isGlowing ? colors : .offUnit)
                    .position(physicsManager.pointP2)
                
                RopeView(startPoint: physicsManager.pointP0,
                          middlePoint: physicsManager.anchor.point,
                          endPoint: physicsManager.pointP2,
                          colors: colors,
                          isGlowing: isGlowing)
            }
        }
        .ignoresSafeArea()
        .background(Color(red: 247 / 255, green: 245 / 255, blue: 230 / 255))
        .gesture(
            DragGesture(minimumDistance: 4, coordinateSpace: .global)
                .onChanged({ (value) in
                    physicsManager.pointP2 = value.location
                })
        )
        .onAppear() {
            physicsManager.startTimer()
        }
    }
    
    // MARK: @ViewBuilder
    
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
                UnitView(unitColors: isGlowing ? colors : .offUnit,
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


struct RopeView_Previews: PreviewProvider {    
    
    static var previews: some View {
        HomeAppView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
