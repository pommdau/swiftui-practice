//
//  tValueText.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/08/04.
//

import SwiftUI

struct tValueText: View {
    
    @Binding var tValue: CGFloat
    
    var body: some View {
        Text("t: \(tValue)")
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.blue, lineWidth: 2)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.blue.opacity(0.1)))
            )
    }
}

struct tValueText_Previews: PreviewProvider {
    static var previews: some View {
        tValueText(tValue: .constant(0.543210))
            .previewLayout(.fixed(width: 200, height: 200))
    }
}
