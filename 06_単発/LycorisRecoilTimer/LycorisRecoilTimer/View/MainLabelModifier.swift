//
//  GlowEffectTextModifier.swift
//  LycorisRecoilTimer
//
//  Created by HIROKI IKEUCHI on 2022/09/28.
//

import SwiftUI

struct MainLabelModifier: ViewModifier {
    
    let fontWeight: Font.Weight
    let lineLimit: Int?
    let multilineTextAlignment: TextAlignment
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .lineLimit(lineLimit)
            .font(.system(size: 100))
            .fontWeight(.bold)
            .minimumScaleFactor(0.01)
            .multilineTextAlignment(multilineTextAlignment)
            .foregroundColor(color)
    }
}

extension View {
    func mainLabel(fontWeight: Font.Weight = .regular,
                   lineLimit: Int? = 1,
                   multilineTextAlignment: TextAlignment = .center,
                   color: Color = .primary) -> some View {
        self.modifier(MainLabelModifier(fontWeight: fontWeight,
                                        lineLimit: lineLimit,
                                        multilineTextAlignment: multilineTextAlignment,
                                        color: color))
    }
}
