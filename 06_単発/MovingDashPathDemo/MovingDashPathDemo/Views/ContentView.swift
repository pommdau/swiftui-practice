//
//  ContentView.swift
//  MovingDashPathDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/20.
//

import SwiftUI

struct ContentView: View {
    @State private var marching = false
    let streamBlue = Color(#colorLiteral(red: 0, green: 0.3725490196, blue: 1, alpha: 1))
    let streamRed = Color(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1))
    
    var body: some View {
        VStack {
            
            Button {
                withAnimation(.linear(duration: 3.0).repeatForever(autoreverses: false)) {
                    marching.toggle()
                }
            } label: {
                Text("Debug Button")
                    .font(.system(size: 20))
                    .foregroundColor(.black.opacity(0.8))
                    .padding()
                    .background(.white.opacity(0.8))
            }
            .padding(.bottom, 40)
            
            Circle()
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
                .frame(width: 300, height: 300)
                .foregroundStyle(
                    .linearGradient(
                        colors: [streamBlue, streamRed],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .offset(x: 0, y: 0)
                .onAppear{
    //                withAnimation(
    //                    .linear(duration: 12)
    //                    .repeatForever(autoreverses: false)) {
    //                        marching.toggle()
    //                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
