//
//  View+blurText.swift
//  LycorisRecoilTimer
//
//  Created by HIROKI IKEUCHI on 2022/09/27.
//

import SwiftUI

extension View {
    func blurText(radius: CGFloat) -> some View {
        ZStack {
            self
            self.blur(radius: radius)
        }
    }
}



struct BlurText_Previews: PreviewProvider {
    static var previews: some View {
        Text("SampleText")
            .blurText(radius: 8)
    }
}
