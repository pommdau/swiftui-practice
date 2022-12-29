//
//  StickyView.swift
//  PageCurlDemo
//
//  Created by HIROKI IKEUCHI on 2022/12/29.
//

import SwiftUI

struct StickyView: View {
    
    @State var message: String = "faioejfoajefioajofjaeiojfioajeoifajoepjf"
    let darkColor: Color
    let lightColor: Color
    let shadowOffset: CGFloat = 2
    
    var body: some View {
        /// [Weighted Layout \(HStack and VStack\) in SwiftUI](https://swiftuirecipes.com/blog/weighted-layout-hstack-and-vstack-in-swiftui)
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Rectangle()
                    .foregroundColor(darkColor)
                    .frame(width: 20)
                TextField("", text: $message)
                    .frame(width: geometry.size.width * 0.8)
                    .frame(maxHeight: .infinity)
                    .padding(.leading, 10)
                    .background(lightColor)
            }
            .compositingGroup()
        }
        .shadow(
            color: .primary,
            radius: CGFloat(shadowOffset),
            x: CGFloat(shadowOffset), y: CGFloat(shadowOffset))
        
    }
}

struct StickyView_Previews: PreviewProvider {
    static var previews: some View {
        StickyView(
                   darkColor: .stickyDarkGreen,
                   lightColor: .stickyLightGreen)
        .frame(width: 300, height: 200)
    }
}
