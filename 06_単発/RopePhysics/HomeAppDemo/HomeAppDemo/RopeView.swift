//
//  RopeView.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/31.
//

import SwiftUI

struct RopeView: View {
    
    private let lineWidth: CGFloat = 8
    private let dashPattern: [CGFloat] = [12, 14]
    
    /// 破線のスタート地点を変更する為のプロパティ
    @State private var dashPhase: CGFloat = 0
    /// Timerのカウントを保持するプロパティ
    @State private var timerCount: CGFloat = 0
    /// 0.1秒毎に`dashPhase`を変更処理を実行する為のTimer
    private let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    let color: Color
    @State var isGlowing: Bool
    
    var body: some View {
        TimelineView(.periodic(from: Date(), by: 1/60)) { context in
            Rope()
        }
    }
    
    @ViewBuilder
    private func Rope() -> some View {
        
        ZStack {
             
            // DEBUGGING
            Button {
                withAnimation {
                    isGlowing.toggle()
                }
            } label: {
                Text("Growing")
            }
                                        
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
                        dash: dashPattern,
                        dashPhase: dashPhase))
                    .foregroundColor(.blue)
                    .onReceive(timer) { _ in
                        timerCount = timerCount > dashPattern.reduce(0){ $0 + $1 } ? 0 : timerCount + 1
                        dashPhase = timerCount
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

struct RopeView_Previews: PreviewProvider {
    static var previews: some View {
        RopeView(color: .blue, isGlowing: false)
    }
}
