//
//  GeometryReaderTestView.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/27.
//

import SwiftUI

struct GeometryReaderTestView: View {
    
    @State private var touchPoint: CGPoint = .zero
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack {
                Color.blue
                Circle()
                    .position(CGPoint(x: touchPoint.x + 50, y: touchPoint.y + 50))
                    .frame(width: 100, height: 100)
            }
            .onTapGesture {
                print("Global center: \(geo.frame(in: .global).minX) x \(geo.frame(in: .global).minY)")
            }
            .simultaneousGesture(
                DragGesture()
                    .onChanged { gesture in
                        //                        touchPoint = CGPoint(x: gesture.location.x - geo.frame(in: .global).midX,
                        //                                             y: gesture.location.y - geo.frame(in: .global).midY)
                        print(gesture.location)
                    }
                    .onEnded { gesture in
                        
                    }
            )
        }
        .frame(width: 300, height: 300)
        .background(.green)
    }
}

struct GeometryReaderTestView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderTestView()
    }
}
