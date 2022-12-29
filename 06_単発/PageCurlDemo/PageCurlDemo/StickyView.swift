//
//  StickyView.swift
//  PageCurlDemo
//
//  Created by HIROKI IKEUCHI on 2022/12/29.
//

import SwiftUI

struct StickyView: View {
    
    @ObservedObject var sticky = Sticky(message: "HogeHoge", positon: .init(x: 100, y: 100))
    
    let shadowOffset: CGFloat = 2
    
    var body: some View {
        /// [Weighted Layout \(HStack and VStack\) in SwiftUI](https://swiftuirecipes.com/blog/weighted-layout-hstack-and-vstack-in-swiftui)
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Rectangle()
                    .foregroundColor(sticky.darkColor)
                    .frame(width: 40)
                TextField("", text: $sticky.message, axis: .vertical)
                    .padding(.horizontal, 8)
                    .foregroundColor(.black)
                    .frame(width: geometry.size.width - 20)
                    .frame(maxHeight: .infinity)
                    .background(sticky.lightColor)
            }
            .compositingGroup()
        }
        .background(.red)
        .shadow(
            color: .primary.opacity(0.2),
            radius: CGFloat(2),
            x: CGFloat(shadowOffset), y: CGFloat(shadowOffset))
        
    }
}

struct StickyView_Previews: PreviewProvider {
    static var previews: some View {
        StickyView()
            .frame(width: 300, height: 200)
    }
}
