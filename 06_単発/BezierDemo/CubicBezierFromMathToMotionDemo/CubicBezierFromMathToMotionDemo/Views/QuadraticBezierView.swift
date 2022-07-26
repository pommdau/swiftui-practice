//
//  QuadraticBezierView.swift
//  CubicBezierFromMathToMotionDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/26.
//

import SwiftUI

struct QuadraticBezierView: View {
    
    private let graphWidth: CGFloat = 300
    @State private var tValue: CGFloat = 0.3
    @State private var isXValueChanging = true
    
    var body: some View {
        VStack {
            QuadraticBezierGraphView(tValue: $tValue)
                .frame(width: graphWidth, height: graphWidth)
            Slider(value: $tValue)
                .frame(width: graphWidth)
                .padding()
        }
    }
}

struct QuadraticBezierView_Previews: PreviewProvider {
    static var previews: some View {
        QuadraticBezierView()
    }
}

