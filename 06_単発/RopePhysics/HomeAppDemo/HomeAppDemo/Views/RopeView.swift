//
//  RopeView.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/31.
//

import SwiftUI

struct RopeView: View {
    
    // MARK: - Properties
    
    let colors: UnitColors
    @Binding var isGlowing: Bool
    @State private var marching = false
    private let lineWidth: CGFloat = 4
    private let dashPattern: [CGFloat] = [12, 14]
    
    private var physicsManager = PhysicsManager()
    
    // MARK: - LifeCycle
    
    init(colors: UnitColors, isGlowing: Binding<Bool>) {
        self.colors = colors
        self._isGlowing = isGlowing
    }
    
    // MARK: - View
    
    var body: some View {
        
        ZStack {
            
            Color(red: 247 / 255, green: 245 / 255, blue: 230 / 255)
            
            AnchorView(colors: isGlowing ? colors : .offUnit)
                .position(physicsManager.pointP0)
            AnchorView(colors: isGlowing ? colors : .offUnit)
                .position(physicsManager.pointP2)
            TimelineView(.periodic(from: Date(), by: 1/60)) { context in
                Rope()
            }
        }
        
    }
    
    // MARK: @ViewBuilder
    
    @ViewBuilder
    private func Rope() -> some View {
        
        ZStack {
            // ロープの外枠
            RopePath
                .stroke(isGlowing ? colors.frameStroke : UnitColors.offUnit.frameStroke,
                        lineWidth: lineWidth + 4)
                .shadow(color: .black.opacity(1.0), radius: 8, x: 0, y: 15)
            
            // ロープの中の色
            RopePath
                .stroke(isGlowing ? .white : .gray,
                        lineWidth: lineWidth)
            
            if isGlowing {
                // Glowing effect
                RopePath
                    .stroke(lineWidth: lineWidth)
                    .foregroundColor(.white)
                    .blur(radius: lineWidth + 2)
                    .zIndex(-1)
                // 点線の移動
                RopePath
                    .stroke(style: StrokeStyle(
                        lineWidth: lineWidth,
                        miterLimit: 10,
                        dash: dashPattern,
                        dashPhase: marching
                        ? -dashPattern.reduce(0){$0 + $1}
                        : dashPattern.reduce(0){$0 + $1}))
                    .foregroundColor(colors.frameStroke)
                    .onAppear {
                        marching = false
                        withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
                            marching.toggle()
                        }
                    }
            }
        }
    }
    
    private var RopePath: Path {
        Path { path in
            path.move(to: physicsManager.pointP0)
            path.addQuadCurve(to: physicsManager.pointP2,
                              control: physicsManager.pointP1)
        }
    }
    
}

struct _RopeView_Previews :View {
    
    @State var isGlowing = true
    
    var body: some View {
        
        ZStack {
            Toggle(isOn: $isGlowing.animation()) {
                HStack {
                    Spacer()
                    Text("Glowing")
                }
            }
            .zIndex(1)
            .offset(x: -150)
            
            RopeView(colors: .unit1, isGlowing: $isGlowing)
        }
        
    }
}

struct RopeView_Previews: PreviewProvider {    
    
    static var previews: some View {
        _RopeView_Previews()
    }
}
