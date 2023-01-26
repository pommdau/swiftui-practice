//
//  GesturePropertiesView1.swift
//  ViewInspectorDemo
//
//  Created by Hiroki Ikeuchi on 2023/01/19.
//

import SwiftUI

struct GesturePropertiesView1: View {
    @State private var isDragging = false
    
    var body: some View {
        let drag = DragGesture(minimumDistance: 20, coordinateSpace: .global)
            .onChanged { _ in self.isDragging = true }
            .onEnded { _ in self.isDragging = false }
                    
        return Rectangle()
            .fill(self.isDragging ? Color.blue : Color.red)
            .frame(width: 10, height: 10)
            .gesture(drag)
    }
}

struct GesturePropertiesView1_Previews: PreviewProvider {
    static var previews: some View {
        GesturePropertiesView1()
    }
}
