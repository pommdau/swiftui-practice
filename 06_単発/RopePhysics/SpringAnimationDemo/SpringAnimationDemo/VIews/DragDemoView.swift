//
//  DragDemoView.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/28.
//

import SwiftUI

struct DragDemoView: View {
    
    @State var position1: CGSize = CGSize(width: 200, height: 300)
    @State var position2: CGSize = CGSize(width: 200, height: 500)
    
    var drag1: some Gesture {
        DragGesture()
        .onChanged{ value in
            self.position1 = CGSize(
                width: value.startLocation.x
                    + value.translation.width,
                height: value.startLocation.y
                    + value.translation.height
            )
        }
        .onEnded{ value in
            self.position1 = CGSize(
                width: value.startLocation.x
                    + value.translation.width,
                height: value.startLocation.y
                    + value.translation.height
            )
        }
    }
    
    var drag2: some Gesture {
        DragGesture()
        .onChanged{ value in
            self.position2 = CGSize(
                width: value.startLocation.x
                    + value.translation.width,
                height: value.startLocation.y
                    + value.translation.height
            )
        }
        .onEnded{ value in
            self.position2 = CGSize(
                width: value.startLocation.x
                    + value.translation.width,
                height: value.startLocation.y
                    + value.translation.height
            )
        }
    }
    
    var body: some View {
        VStack {
            Text("x: \(position1.width)")
            Text("y: \(position1.height)")
            
            ZStack {
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.red)
                    .position(x: position1.width, y: position1.height)
                    .gesture(drag1)
                
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .position(x: position2.width, y: position2.height)
                    .gesture(drag2)
            }
        }
    }
}

struct DragDemoView_Previews: PreviewProvider {
    static var previews: some View {
        DragDemoView()
    }
}
