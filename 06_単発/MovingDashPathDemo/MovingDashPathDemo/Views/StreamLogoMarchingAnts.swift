//
//  StreamLogoMarchingAnts.swift
//  MovingDashPathDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/20.
//

import SwiftUI

struct StreamLogoMarchingAnts: View {
    
    @State private var marching = false
    let streamBlue = Color(#colorLiteral(red: 0, green: 0.3725490196, blue: 1, alpha: 1))
    let streamRed = Color(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1))
    
    var body: some View {
        Path.crown
            .stroke(
                style: StrokeStyle(
                    lineWidth: 2,
                    lineCap: .round,
                    lineJoin: .round,
                    miterLimit: 10,
                    dash: [7, 5],  // [線の長さ, 空白の長さ, 線の長さ, 空白の長さ・・・]
                    dashPhase: marching ? 100 : -100
                )
            )
            .foregroundStyle(
                .linearGradient(
                    colors: [streamBlue, streamRed],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .offset(x: 120, y: 340)
            .onAppear{
                withAnimation(
                    .linear(duration: 12)
                    .repeatForever(autoreverses: false)) {
                        marching.toggle()
                    }
            }
    }
    
}

struct StreamLogoMarchingAnts_Previews: PreviewProvider {
    static var previews: some View {
        StreamLogoMarchingAnts()
            .preferredColorScheme(.dark)
    }
}

