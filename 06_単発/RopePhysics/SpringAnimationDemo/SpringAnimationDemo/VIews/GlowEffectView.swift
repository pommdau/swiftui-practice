//
//  GlowEffectView.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/27.
//

import SwiftUI

struct GlowEffectView: View {
    
    @State var isGlowing : Bool = true
    
    /// 破線のスタート地点を変更する為のプロパティ
    @State private var dashPhase: CGFloat = 0
    /// Timerのカウントを保持するプロパティ
    @State private var timerCount: CGFloat = 0
    /// 0.1秒毎に`dashPhase`を変更処理を実行する為のTimer
    private let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    private let lineWidth: CGFloat = 10
    
    var body: some View {
        ZStack {
            Color.gray
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Toggle(isOn: $isGlowing) {
                    Text("Glowing")
                        .foregroundColor(.white)
                }
                .frame(width: 120)
                
                ZStack {
                    Text("")
                        .fontWeight(.bold)
                        .font(.system(size: 180))
                        .foregroundColor(.white)
                        .blur(radius: isGlowing ? 15.0 : 0)
                    Text("")
                        .fontWeight(.bold)
                        .font(.system(size: 180))
                        .foregroundColor(.white)
                }
                
                ZStack {
//                    Path { path in
//                        path.move(to: CGPoint(x: 10, y: 400))
//                        path.addLine(to: CGPoint(x: 400, y: 400))
//                    }
//                    .stroke(lineWidth: 20)
//                    .foregroundColor(.white)
//                    .blur(radius: isGlowing ? 30.0 : 0)

                    Path { path in
                        path.move(to: CGPoint(x: 10, y: 400))
                        path.addLine(to: CGPoint(x: 400, y: 400))
                    }
                    .stroke(.white, lineWidth: lineWidth)
                    .foregroundColor(.white)
                    
                    Path { path in
                        path.move(to: CGPoint(x: 10, y: 400))
                        path.addLine(to: CGPoint(x: 400, y: 400))
                    }
                    .stroke(style: StrokeStyle(
                        lineWidth: lineWidth,
                        dash: [10, 14],
                        dashPhase: dashPhase))
                    .foregroundColor(.blue)
                    .onReceive(timer) { _ in
                        timerCount = timerCount > 24 ? 0 : timerCount + 1
                        dashPhase = timerCount
                    }
                    
                    ZStack {
                                                
//                        Circle()
//                            .stroke(lineWidth: 10)
//                            .foregroundColor(.white)
//                            .frame(width: 200, height: 200)
//                            .onReceive(timer) { _ in
//                                timerCount = timerCount > 10 ? 0 : timerCount + 1
//                                dashPhase = timerCount
//                            }
                        
//                        Circle()
//                            .stroke(style: StrokeStyle(
//                                lineWidth: 10,
//                                dash: [20, 24],
//                                dashPhase: dashPhase))
//                            .foregroundColor(.red)
//                            .frame(width: 200, height: 200)
//                            .onReceive(timer) { _ in
//                                timerCount = timerCount > 44 ? 0 : timerCount + 1
//                                dashPhase = timerCount
//                            }
                        
                    }
                }
                
            }
        }
    }
}

struct GlowEffectView_Previews: PreviewProvider {
    static var previews: some View {
        GlowEffectView()
    }
}
