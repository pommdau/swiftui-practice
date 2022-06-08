//
//  ContentView.swift
//  ZoomableViewDemo
//
//  Created by HIROKI IKEUCHI on 2022/06/08.
//

import SwiftUI

struct ContentView: View {
            
    private let imageNames = ["image01", "image02", "image03"]
        
    var zoomableViews: [ZoomableViewDemo] {
        var zoomableViews = [ZoomableViewDemo]()
        for imageName in imageNames {
            zoomableViews.append(ZoomableViewDemo(imageName: imageName))
        }
        return zoomableViews
    }
    
    var body: some View {
        PageView(pages: zoomableViews)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
