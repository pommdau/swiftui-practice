//
//  ZoomableView.swift
//  ZoomableViewDemo
//
//  Created by HIROKI IKEUCHI on 2022/06/08.
//

import SwiftUI

struct ZoomableViewDemo: View {
    
    let imageName: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()                
                .frame(width: 300, height: 300)
                .foregroundColor(.blue)
            Text("\(imageName)")
        }
    }
}

struct ZoomableView_Previews: PreviewProvider {
    static var previews: some View {
        ZoomableViewDemo(imageName: "image01")
    }
}
