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
            DetailView(imageName: "image01"),
            DetailView(imageName: "image04"),
            DetailView(imageName: "image03"),
        ])
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

