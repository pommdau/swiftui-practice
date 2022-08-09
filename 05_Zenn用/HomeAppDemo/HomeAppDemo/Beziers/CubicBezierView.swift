//
//  CubicBezierView.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/08/09.
//

import SwiftUI

struct CubicBezierView: View {
    
    private let graphLength: CGFloat = 300
    @State private var tValue: CGFloat = 0.3
    
    var body: some View {
        VStack {
            CubicBezierGraphView(tValue: $tValue)
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

struct CubicBezierView_Previews: PreviewProvider {
    static var previews: some View {
        CubicBezierView()
    }
}
