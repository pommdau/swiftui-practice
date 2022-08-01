//
//  RopeView.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/08/01.
//

import SwiftUI

struct RopeView: View {
    
    // MARK: - Properties
    
    let startPoint: CGPoint
    let middlePoint: CGPoint
    let endPoint: CGPoint
    @Binding var colors: UnitColors
    
    var isGlowing: Bool {
        return colors != .offUnit
    }

    private let lineWidth: CGFloat = 4
    private let dashPattern: [CGFloat] = [12, 14]
    @State private var marching = false
    
    // MARK: - Computed Properties
            
    var RopePath: Path {
        Path { path in
            path.move(to: startPoint)
            path.addQuadCurve(to: endPoint,
                              control: middlePoint)
        }
    }
    
    // MARK: - LifeCycle
    
    init(startPoint: CGPoint,
         middlePoint: CGPoint,
         endPoint: CGPoint,
         colors: Binding<UnitColors>
    ) {
        self.startPoint = startPoint
        self.middlePoint = middlePoint
        self.endPoint = endPoint
        self._colors = colors
    }
    
    // MARK: - View
    
    var body: some View {
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
                    .stroke(lineWidth: lineWidth + 2)
                    .foregroundColor(colors.frameFill)
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
}

struct _RopeView2_Previews: View {
    
    @State var colors: UnitColors = .unit1
    
    var body: some View {        
        ZStack {
            RopeView(startPoint: .init(x: 100, y: 100),
                      middlePoint: .init(x: 200, y: 300),
                      endPoint: .init(x: 400, y: 100),
                     colors: $colors)
        }
    }
}

struct RopeView2_Previews: PreviewProvider {
    static var previews: some View {
        _RopeView2_Previews()
    }
}
