//
//  CubicBezierView.swift
//  CubicBezierFromMathToMotionDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/26.
//

import SwiftUI

struct CubicBezierView: View {
    
    private let graphWidth: CGFloat = 300
    @State private var tValue: CGFloat = 0.3
    @State private var isXValueChanging = true
    
    var body: some View {
        VStack {
            CubicBezierGraphView(tValue: $tValue)
                .frame(width: graphWidth, height: graphWidth)
            VStack(alignment: .leading) {
                Text("t: \(tValue)")
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 2)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.blue.opacity(0.1)))
                    )
                    .padding(.leading, 14)
                Slider(value: $tValue)
                    .padding()
            }
            .frame(width: graphWidth)
        }
    }
}

struct CubicBezierView_Previews: PreviewProvider {
    static var previews: some View {
        CubicBezierView()
    }
}

