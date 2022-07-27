//
//  DragDemoView.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/28.
//

import SwiftUI

struct DragDemoView: View {
    
    @State var position: CGSize = CGSize(width: 200, height: 300)
    
    var drag: some Gesture {
        DragGesture()
        .onChanged{ value in
            self.position = CGSize(
                width: value.startLocation.x
                    + value.translation.width,
                height: value.startLocation.y
                    + value.translation.height
            )
        }
        .onEnded{ value in
            self.position = CGSize(
                width: value.startLocation.x
                    + value.translation.width,
                height: value.startLocation.y
                    + value.translation.height
            )
        }
        
    }
    
    var body: some View {
        VStack {
            Text("x: \(position.width)")
            Text("y: \(position.height)")
            
            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
                .position(x: position.width, y: position.height)
                .gesture(drag)
        }
    }
}

struct DragDemoView_Previews: PreviewProvider {
    static var previews: some View {
        DragDemoView()
    }
}
