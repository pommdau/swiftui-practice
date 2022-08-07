//
//  LinearInterpolationView.swift
//  CubicBezierFromMathToMotionDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/26.
//

import SwiftUI

struct LinearInterpolationView: View {
    
    private let graphLength: CGFloat = 300
    @State private var tValue: CGFloat = 0.3
    
    var body: some View {
        VStack {
            LinearInterpolationGraphView(tValue: $tValue)
                .frame(width: graphLength, height: graphLength)
            
            VStack(alignment: .leading) {
                tValueText(tValue: $tValue)
                    .padding(.leading, 14)
                
                Slider(value: $tValue)
                    .frame(width: graphLength)
                    .padding()
                

            }
        }
    }
}

struct LinearInterpolationView_Previews: PreviewProvider {
    static var previews: some View {
        LinearInterpolationView()
    }
}

