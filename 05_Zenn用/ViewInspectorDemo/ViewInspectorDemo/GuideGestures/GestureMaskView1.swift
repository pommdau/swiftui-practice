//
//  GestureMaskView1.swift
//  ViewInspectorDemo
//
//  Created by Hiroki Ikeuchi on 2023/01/19.
//

import SwiftUI

struct GestureMaskView1: View {
    @State var tapped = false
    
    var body: some View {
        let gesture = TapGesture()
            .onEnded { _ in self.tapped.toggle() }
        
        return Rectangle()
            .fill(self.tapped ? Color.blue : Color.red)
            .frame(width: 10, height: 10)
            .gesture(gesture, including: .gesture)
    }
}

struct GestureMaskView1_Previews: PreviewProvider {
    static var previews: some View {
        GestureMaskView1()
    }
}
