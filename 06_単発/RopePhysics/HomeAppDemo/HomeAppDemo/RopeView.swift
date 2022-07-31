//
//  RopeView.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/31.
//

import SwiftUI

struct RopeView: View {
    
    // MARK: - Properties
        
    let color: Color
    @Binding var isGlowing: Bool
    
    @State private var marching = false
    private let lineWidth: CGFloat = 4
    private let dashPattern: [CGFloat] = [12, 14]
            
    // MARK: - Computed Properties
        
    // MARK: - View

    var body: some View {
        TimelineView(.periodic(from: Date(), by: 1/60)) { context in
            Rope()
        }
    }
    
    // MARK: @ViewBuilder
    
    @ViewBuilder
    private func Rope() -> some View {
        
        ZStack {
            // ロープの外枠
            RopePath
                .stroke(isGlowing ? color : Color(uiColor: #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)),
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
                    .foregroundColor(color)
                    .onAppear {
                        marching = false
                        withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
                            marching.toggle()
                        }
                    }
            }
            
        }

        .background(.black.opacity(0.5))
    }
    
    private var RopePath: Path {
        Path { path in
            path.move(to: CGPoint(x: 10, y: 100))
            path.addQuadCurve(to: CGPoint(x: 400, y: 100),
                              control: CGPoint(x: 200, y: 200))
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
            
            RopeView(color: .red, isGlowing: $isGlowing)
        }
        
    }
}

struct RopeView_Previews: PreviewProvider {    
    
    static var previews: some View {
       _RopeView_Previews()
    }
}
