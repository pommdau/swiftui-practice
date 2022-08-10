//
//  RopeView.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/08/01.
//

import SwiftUI

struct RopeView: View {
    
    // MARK: - Properties
    
    let pointP0: CGPoint
    let pointP1: CGPoint
    let pointP2: CGPoint
    @Binding var colors: UnitColors
    
    var isGlowing: Bool {
        return colors != .offUnit
    }

    private let lineWidth: CGFloat = 2
    private let dashPattern: [CGFloat] = [12, 14]
    @State private var marching = false
    
    // MARK: - Computed Properties
            
    var RopePath: Path {
        Path { path in
            path.move(to: pointP0)
            path.addQuadCurve(to: pointP2,
                              control: pointP1)
        }
    }
    
    // MARK: - LifeCycle
    
    init(pointP0: CGPoint,
         pointP1: CGPoint,
         pointP2: CGPoint,
         colors: Binding<UnitColors>
    ) {
        self.pointP0 = pointP0
        self.pointP1 = pointP1
        self.pointP2 = pointP2
        self._colors = colors
    }
    
    // MARK: - View
    
    var body: some View {
        ZStack {
                    
            // ロープの外枠
            RopePath
                .stroke(isGlowing ? colors.frameStroke : UnitColors.offUnit.iconFill,
                        lineWidth: lineWidth + 4)
                .shadow(color: .black.opacity(1.0), radius: 8, x: 0, y: 15)
            
            // ロープの中の色
            RopePath
                .stroke(isGlowing ? .white : UnitColors.offUnit.iconFill,
                        lineWidth: lineWidth)
            
            if isGlowing {
                // Glowing effect
                RopePath
                    .stroke(lineWidth: lineWidth + 6)
                    .foregroundColor(.white)
                    .blur(radius: lineWidth + 2)
                    .zIndex(-1)
                // 移動する破線
                RopePath
                    .stroke(style: StrokeStyle(
                        lineWidth: lineWidth + 2,
                        miterLimit: 10,
                        dash: dashPattern,
                        dashPhase: marching
                        ? -dashPattern.reduce(0){$0 + $1}
                        : dashPattern.reduce(0){$0 + $1}))
                    .foregroundColor(colors.frameStroke)
                    .onAppear {
                        marching = false
                        withAnimation(.linear(duration: 0.5).repeatForever(autoreverses: false)) {
                            marching.toggle()
                        }
                    }
            }
        }
    }
}

struct _RopeView2_Previews: View {
    
    @State var colors: UnitColors = .unit1
    
    var body: some View {        
        VStack {
            Button {
                colors = .offUnit
            } label: {
                Text("OffUnit")
            }
            
            Button {
                colors = .unit1
            } label: {
                Text("Unit1")
            }
            
            RopeView(pointP0: .init(x: 100, y: 100),
                     pointP1: .init(x: 200, y: 300),
                     pointP2: .init(x: 400, y: 100),
                     colors: $colors)
        }
        .background(.black.opacity(0.5))
    }
}

struct RopeView2_Previews: PreviewProvider {
    static var previews: some View {
        _RopeView2_Previews()
    }
}
