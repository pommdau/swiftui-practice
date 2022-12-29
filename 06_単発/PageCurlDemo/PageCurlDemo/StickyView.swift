//
//  StickyView.swift
//  PageCurlDemo
//
//  Created by HIROKI IKEUCHI on 2022/12/29.
//

import SwiftUI

struct StickyView: View {
    
    private let message = "HogeHoge"
    private let color: Color = Bool.random() ? .green : .blue
    
    var body: some View {
        Text(message)
            .background(color)
    }
}

struct StickyView_Previews: PreviewProvider {
    static var previews: some View {
        StickyView()
    }
}
