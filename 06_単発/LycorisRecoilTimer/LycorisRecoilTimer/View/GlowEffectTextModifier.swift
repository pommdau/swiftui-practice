//
//  GlowEffectTextModifier.swift
//  LycorisRecoilTimer
//
//  Created by HIROKI IKEUCHI on 2022/09/28.
//

import SwiftUI

struct GlowEffectTextModifier: ViewModifier {
    
    let lineLimit: Int?
    let multilineTextAlignment: TextAlignment
    
    func body(content: Content) -> some View {
        content
            .lineLimit(lineLimit)
            .font(.system(size: 100))
            .fontWeight(.bold)
            .minimumScaleFactor(0.01)
            .multilineTextAlignment(multilineTextAlignment)
            .foregroundColor(.white)
            .glowEffect(radius: 8)
    }
}

extension View {
    func glowEffectText(lineLimit: Int? = 1,
                        multilineTextAlignment: TextAlignment = .center) -> some View {
        self.modifier(GlowEffectTextModifier(lineLimit: lineLimit,
                                             multilineTextAlignment: multilineTextAlignment))
    }
}
