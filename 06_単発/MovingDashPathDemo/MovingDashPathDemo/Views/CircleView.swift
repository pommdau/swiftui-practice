//
//  CircleView.swift
//  MovingDashPathDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/20.
//

import SwiftUI

struct CircleView: View {
    @State private var marching = false
        @State private var isAnimationg = false
        let streamBlue = Color(#colorLiteral(red: 0, green: 0.3725490196, blue: 1, alpha: 1))
        let streamRed = Color(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1))
        
        var body: some View {
            VStack {
                
                Button {
                    isAnimationg.toggle()
                    withAnimation(
                        isAnimationg ?
                            .linear(duration: 2.0).repeatForever(autoreverses: false) :
                                .default
                        ) {
                        marching.toggle()
                    }
                } label: {
                    Text(isAnimationg ? "Stop" : "Start")
                        .font(.system(size: 40))
                        .foregroundStyle(
                            .linearGradient(
                                colors: [.yellow, .green],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                }
                .padding(.bottom, 40)
                
    //            Circle()
                Rectangle()
                    .stroke(
                        style: StrokeStyle(
                            lineWidth: 2,
                            lineCap: .round,
                            lineJoin: .round,
                            miterLimit: 10,
                            dash: [30, 30],  // [線の長さ, 空白の長さ, 線の長さ, 空白の長さ・・・]
                            dashPhase: marching ? 100 : -100
                        )
                    )
                    .frame(width: 300, height: 300)
                    .foregroundStyle(
                        .linearGradient(
                            colors: [streamBlue, streamRed],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .offset(x: 0, y: 0)
            }
        }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView()
            .preferredColorScheme(.dark)
    }
}

