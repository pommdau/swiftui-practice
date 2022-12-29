//
//  ContentView.swift
//  PageCurlDemo
//
//  Created by HIROKI IKEUCHI on 2022/12/29.
//

import SwiftUI


struct CounterView: View {

    @State var index: Int = 0

    var body: some View {
        Pages(currentPage: $index, transitionStyle: .pageCurl, hasControl: false) {
            StickyView()
                .frame(width: 200, height: 100)
                .background(.red)
            StickyView()
                .frame(width: 200, height: 100)
                .background(.red)
            StickyView()
                .frame(width: 200, height: 100)
                .background(.red)
        }
        .frame(width: 200, height: 100)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView()
    }
}

