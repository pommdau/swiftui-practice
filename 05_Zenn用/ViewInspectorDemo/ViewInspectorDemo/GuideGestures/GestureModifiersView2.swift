//
//  GestureModifiersView2.swift
//  ViewInspectorDemo
//
//  Created by Hiroki Ikeuchi on 2023/01/19.
//

import SwiftUI

struct GestureModifiersView2: View {
    @State var tapped = false
    
    var body: some View {
        let gesture = TapGesture()
            .onEnded { _ in self.tapped.toggle() }
        
        return Rectangle()
            .fill(self.tapped ? Color.blue : Color.red)
            .frame(width: 100, height: 100)
            .highPriorityGesture(gesture)
    }
}

struct GestureModifiersView2_Previews: PreviewProvider {
    static var previews: some View {
        GestureModifiersView2()
    }
}
