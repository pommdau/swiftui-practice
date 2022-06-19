//
//  DemoView.swift
//  ZoomableViewDemo
//
//  Created by HIROKI IKEUCHI on 2022/06/08.
//

import SwiftUI

struct DemoView: View {
    var body: some View {
        
        ScrollView([.horizontal, .horizontal], showsIndicators: true) {
            Image("image01")
                .resizable()
                .aspectRatio(contentMode: .fit)
    //            .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                .frame(maxWidth: 200, maxHeight: 200)
                .scaleEffect(3.0)
        }
    }
}

struct DemoView_Previews: PreviewProvider {
    static var previews: some View {
        DemoView()
    }
}
