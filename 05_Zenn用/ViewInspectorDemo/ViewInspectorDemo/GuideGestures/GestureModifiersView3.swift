//
//  GestureModifiersView3.swift
//  ViewInspectorDemo
//
//  Created by Hiroki Ikeuchi on 2023/01/19.
//

import SwiftUI

struct GestureModifiersView3: View {
    @State var tapped = false
    
    var body: some View {
        let gesture = TapGesture()
            .onEnded { _ in self.tapped.toggle() }
        
        return Rectangle()
            .fill(self.tapped ? Color.blue : Color.red)
            .frame(width: 10, height: 10)
            .simultaneousGesture(gesture)
    }
}

struct GestureModifiersView3_Previews: PreviewProvider {
    static var previews: some View {
        GestureModifiersView3()
    }
}
