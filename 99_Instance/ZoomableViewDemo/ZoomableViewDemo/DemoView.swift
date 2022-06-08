//
//  DemoView.swift
//  ZoomableViewDemo
//
//  Created by HIROKI IKEUCHI on 2022/06/08.
//

import SwiftUI

struct DemoView: View {
    var body: some View {
        Image("image01")
            .resizable()
            .aspectRatio(contentMode: .fit)
//            .padding()
            .scaleEffect(1.0)
    }
}

struct DemoView_Previews: PreviewProvider {
    static var previews: some View {
        DemoView()
    }
}
