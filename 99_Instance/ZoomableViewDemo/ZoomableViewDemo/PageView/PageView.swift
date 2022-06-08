//
//  PageView.swift
//  TransitionDemo
//
//  Created by HIROKI IKEUCHI on 2022/06/07.
//

import SwiftUI

struct PageView<Page: View>: View {
    var pages: [Page]
    @State private var currentPage = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            PageViewController(pages: pages, currentPage: $currentPage)
            PageControl(numberOfPages: pages.count, currentPage: $currentPage)
                .frame(width: CGFloat(pages.count * 18))
                .padding(.trailing)
                .background(.red)
        }
    }
    
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(pages: [
            Image("renban01")
                .resizable()
                .frame(width: 100, height: 100),
            Image("sample_01")
                .resizable()
                .frame(width: 100, height: 100),
            Image("renban01")
                .resizable()
                .frame(width: 100, height: 100),
        ])
    }
}
