//
//  TrailingIconLabelStyle.swift
//  Scrumdinger
//
//  Created by HIROKI IKEUCHI on 2022/08/08.
//

import SwiftUI

struct TrailingIconLabelStyle: LabelStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

extension LabelStyle where Self == TrailingIconLabelStyle {
    /*
     ref: [What does Self \{ Self\(\) \} mean?](https://developer.apple.com/forums/thread/705545)
     This means...
     
     static var trailingIcon: Self {
         get {
             return Self()
         }
     }
     */
    static var trailingIcon: Self { Self() }
}
