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
            Text("LinearInterpolationView")
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

struct LinearInterpolationView_Previews: PreviewProvider {
    static var previews: some View {
        LinearInterpolationView()
    }
}
