//
//  QuadraticBezierView.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/08/04.
//

import SwiftUI

struct QuadraticBezierView: View {
    
    private let graphLength: CGFloat = 300
    @State private var tValue: CGFloat = 0.3
    
    var body: some View {
        VStack {
            QuadraticBezierGraphView(tValue: $tValue)
                .frame(width: graphLength, height: graphLength)
            
            VStack(alignment: .leading) {
                tValueText(tValue: $tValue)
                Slider(value: $tValue)
                    .padding()
            }
            .frame(width: graphLength)
        }
    }
}

struct QuadraticBezierView_Previews: PreviewProvider {
    static var previews: some View {
        QuadraticBezierView()
    }
}

