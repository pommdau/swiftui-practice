//
//  ContentView.swift
//  ZoomableViewDemo
//
//  Created by HIROKI IKEUCHI on 2022/06/08.
//

import SwiftUI

struct ContentView: View {
    
    private let imageNames = ["image01", "image02", "image03"]
    
    var body: some View {
        PageView(pages: [
            
            ZoomableView(
                size: CGSize(width: 200, height: 200),
                content: {
                    VStack {
                        Text("image01")
                        Image("image01")
                    }
                }),
            ZoomableView(
                size: CGSize(width: 200, height: 200),
                content: {
                    VStack {
                        Text("image02")
                        Image("image02")
                    }
                }),
            ZoomableView(
                size: CGSize(width: 200, height: 200),
                content: {
                    VStack {
                        Text("image03")
                        Image("image03")
                    }
                })
        ])
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

