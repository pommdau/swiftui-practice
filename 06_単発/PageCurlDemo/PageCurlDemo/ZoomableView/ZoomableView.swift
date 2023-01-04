//
//  ZoomableView.swift
//  PageCurlDemo
//
//  Created by HIROKI IKEUCHI on 2023/01/03.
//

import SwiftUI

struct ZoomableView: View {
    
    @State var scale:CGFloat = 1.0
    @State var initialScale: CGFloat = 1.0
    
    var body: some View {
        ScrollView([.horizontal, .vertical], showsIndicators: false) {
            ZStack {
                Color.green.opacity(0.2)
                Circle()
                    .fill(Color.red)
                    .frame(width:100, height:100)
                Rectangle()
                    .fill(.blue)
                    .frame(width: 50, height: 40)
            }
            .frame(width: 1000, height: 1000)
        }
        .scaleEffect(scale)
        .background(Color.red.opacity(0.2))
        .gesture(magnificationGesture())
    }
    
    private func magnificationGesture() -> some Gesture {
        MagnificationGesture()
            .onChanged({ value in
                scale = max(value * initialScale, 1.0)  // 縮小はさせない
            })
            .onEnded{ _ in
                initialScale = scale
            }
    }
}
struct ZoomableView_Previews: PreviewProvider {
    static var previews: some View {
        ZoomableView()
    }
}
