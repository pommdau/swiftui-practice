//
//  Home.swift
//  DynamicTabIndicator
//
//  Created by HIROKI IKEUCHI on 2022/10/06.
//

import SwiftUI

struct Home: View {
    
    @State private var tabs = Tab.sampleTabs()
    @State private var offset: CGFloat = 0
    @State private var currentTab: Tab = Tab.sampleTabs().first!
    
    var body: some View {
        ZStack(alignment: .top) {
            TabView(selection: $currentTab) {
                ForEach(tabs) { tab in
                    GeometryReader { proxy in
                        let size = proxy.size
                        
                        Image(tab.sampleImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .clipped()
                    }
                    .ignoresSafeArea()
                    .offsetX { value in
                        // MARK: - Calculating offset with the help of currently active tab
                        if currentTab == tab {
                            offset = value
                        }
                    }
                    .tag(tab)
                }
            }
            .ignoresSafeArea()
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            // MARK: - Debug
            Text("\(offset)")
                .foregroundColor(.blue)
                .offset(y: 400)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
