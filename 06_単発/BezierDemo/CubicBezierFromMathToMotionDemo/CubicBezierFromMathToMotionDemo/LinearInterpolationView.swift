//
//  LinearInterpolationView.swift
//  CubicBezierFromMathToMotionDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/26.
//

import SwiftUI

struct LinearInterpolationView: View {
    
    @State private var xValue: CGFloat = 0.3
    @State private var isXValueChanging = true
    
    var body: some View {
        VStack {
            LinearInterpolationGraphView(xValue: $xValue)
            Slider(value: $xValue)
                .padding()
            Button {
                isXValueChanging.toggle()
            } label: {
                Image(systemName: isXValueChanging ? "pause" : "play")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .tint(.black)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray).opacity(0.2)
                            .frame(width: 50, height: 50))
            }

        }
    }
}

//struct LinearInterpolationView_Previews: PreviewProvider {
//    static var previews: some View {
//        LinearInterpolationView()
//    }
//}

struct LinearInterpolationGraphView: View {
    
    @Binding var xValue: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                    path.move(to: CGPoint(x: geometry.size.width * 0.1,
                                          y: geometry.size.height * 0.1))
                    path.addLine(to: CGPoint(x: geometry.size.width * 0.9,
                                             y: geometry.size.height * 0.9))
                }
                .stroke(lineWidth: 10)
                .foregroundStyle(
                    .linearGradient(
                        colors: [.pink, .blue],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: 400, height: 400)
            }
            
        }
    }
}

struct LinearInterpolationGraphViewView_Previews: PreviewProvider {
    static var previews: some View {
        LinearInterpolationGraphView(xValue: Binding.constant(0.5))
            .frame(width: 400, height: 400)
            .background(.gray.opacity(0.3))
    }
}



