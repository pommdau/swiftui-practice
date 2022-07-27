//
//  RopeView.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/27.
//

import SwiftUI

class Point: ObservableObject {
    var position: CGPoint = .zero
}

struct RopeView: View {
    
    @ObservedObject private var point = Point()
    @State private var touchPoint: CGPoint = .zero
    
    var body: some View {
        TimelineView(.periodic(from: Date(), by: 1/60)) { _ in
            VStack {
                ZStack {
                    Circle()
                        .position(point.position)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                }
            }
        }
        
        .position(x: 0, y: 0)
        //        .position(x: 10, y: 10)
        //        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.green)
        .simultaneousGesture(
            DragGesture()
                .onChanged { gesture in
                    point.position = CGPoint(x: gesture.location.x,
                                             y: gesture.location.y)
                    //                        print(geo.frame(in: .global).minX)
                    
                }
                .onEnded { gesture in
                    
                }
        )
    }
}

struct RopeView_Previews: PreviewProvider {
    static var previews: some View {
        RopeView()
    }
}
