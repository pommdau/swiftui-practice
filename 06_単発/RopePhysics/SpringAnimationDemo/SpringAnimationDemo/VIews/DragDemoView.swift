//
//  DragDemoView.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/28.
//

import SwiftUI

struct DragDemoView: View {
    
    @State var position1: CGPoint = .init(x: 200, y: 300)
    @State var position2: CGPoint = .init(x: 200, y: 500)
    
    var drag1: some Gesture {
        DragGesture()
        .onChanged{ value in
            self.position1 = CGPoint(
                x: value.startLocation.x
                    + value.translation.width,
                y: value.startLocation.y
                    + value.translation.height
            )
        }
        .onEnded{ value in
            self.position1 = CGPoint(
                x: value.startLocation.x
                    + value.translation.width,
                y: value.startLocation.y
                    + value.translation.height
            )
        }
    }
    
    var drag2: some Gesture {
        DragGesture()
        .onChanged{ value in
            self.position2 = CGPoint(
                x: value.startLocation.x
                    + value.translation.width,
                y: value.startLocation.y
                    + value.translation.height
            )
        }
        .onEnded{ value in
            self.position2 = CGPoint(
                x: value.startLocation.x
                    + value.translation.width,
                y: value.startLocation.y
                    + value.translation.height
            )
        }
    }
    
    var body: some View {
        VStack {
            Group {
                Text("x: \(position1.x)")
                Text("y: \(position1.y)")
            }
            .foregroundColor(.red)
            
            Rectangle()
                .frame(width: 200, height: 200)
            
            Group {
                Text("x: \(position2.x)")
                Text("y: \(position2.y)")
            }
            .foregroundColor(.blue)
            
            ZStack {
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.red)
                    .position(position1)
                    .gesture(drag1)
                
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .position(position2)
                    .gesture(drag2)
            }
            .background(.green)
        }
    }
}

struct DragDemoView_Previews: PreviewProvider {
    static var previews: some View {
        DragDemoView()
    }
}
