//
//  Anchor.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/30.
//

import SwiftUI

struct Anchor: View {
    
    let colors: UnitColors
    
    var body: some View {
        Circle()
            .stroke(colors.iconStroke, lineWidth: 4)
            .background(Circle().foregroundColor(colors.iconFill))
            .frame(width: 44,
                   height: 44)
    }
}

struct Anchor_Previews: PreviewProvider {
    static var previews: some View {
        Anchor(colors: .offUnit)
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
