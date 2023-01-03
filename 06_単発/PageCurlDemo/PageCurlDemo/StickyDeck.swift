//
//  StickyDeck.swift
//  PageCurlDemo
//
//  Created by HIROKI IKEUCHI on 2023/01/03.
//

import SwiftUI

struct StickyDeck: View {
    @State private var sticky: Sticky = .init(message: "", positon: .zero)
    private let shadowOffset: CGFloat = 2
    
    var body: some View {
            ZStack {
                Group {                    
                    stickyDeckTemplate()
                    stickyDeckTemplate()
                        .offset(x: 4, y: 0)
                    stickyDeckTemplate()
                        .offset(x: 8, y: 0)
                }
            }
            .compositingGroup()
            .shadow(
                color: .primary.opacity(0.6),
                radius: CGFloat(2),
                x: CGFloat(shadowOffset), y: CGFloat(shadowOffset))
    }
    
    @ViewBuilder
    private func stickyDeckTemplate() -> some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Rectangle()
                    .frame(width: 1)
                    .foregroundColor(.black.opacity(0.2))
                Rectangle()
                    .foregroundColor(sticky.darkColor)
                    .frame(width: 20)
                Rectangle()
                    .foregroundColor(sticky.lightColor)
                    .frame(width: geometry.size.width - 40)
                    .frame(maxHeight: .infinity)
            }
        }
    }
}

struct StickyDeck_Previews: PreviewProvider {
    static var previews: some View {
        StickyDeck()
            .frame(width: 200, height: 100)
    }
}
