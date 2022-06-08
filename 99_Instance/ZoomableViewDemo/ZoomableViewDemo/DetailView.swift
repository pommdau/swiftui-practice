//
//  ZoomableView.swift
//  ZoomableViewDemo
//
//  Created by HIROKI IKEUCHI on 2022/06/08.
//

import SwiftUI

struct DetailView: View {
    
    let imageName: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .modifier(IKEHZoomableModifier())
            Text("\(imageName)")
        }
    }
}

struct ZoomableView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(imageName: "image01")
    }
}

public struct IKEHZoomableModifier: ViewModifier {
    
    public func body(content: Content) -> some View {
        content
    }
}
