//
//  GestureKeyboardModifiersVIew.swift
//  ViewInspectorDemo
//
//  Created by Hiroki Ikeuchi on 2023/01/19.
//

import SwiftUI

#if os(macOS)  // Preview不可(恐らくプロジェクト側でmacOSが未対応のため)
struct GestureKeyboardModifiersVIew: View {
    @State var tapped = false
    
    var body: some View {
        // Shift + Control + Clickで色が変わる
        let gesture = TapGesture()
            .onEnded { _ in self.tapped.toggle() }
            .modifiers(.shift)
            .modifiers(.control)
        
        return Rectangle()
            .fill(self.tapped ? Color.blue : Color.red)
            .frame(width: 10, height: 10)
            .gesture(gesture)
    }
}

struct GestureKeyboardModifiersVIew_Previews: PreviewProvider {
    static var previews: some View {
        GestureKeyboardModifiersVIew()
    }
}
#endif
