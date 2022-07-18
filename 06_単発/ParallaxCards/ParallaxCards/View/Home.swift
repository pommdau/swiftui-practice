//
//  Home.swift
//  ParallaxCards
//
//  Created by HIROKI IKEUCHI on 2022/07/18.
//

import SwiftUI

struct Home: View {
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .font(.title3)
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "person")
                        .font(.title3)
                }
            }
            .foregroundColor(.white)
            
            Text("Exclusive trips just for you")
                .font(.system(.title3, design: .serif))
                .italic()
                .foregroundColor(.white)
                .padding(.top, 10)
            
            ParallaxCards()
                .padding(.horizontal, -15)
            
            TabBar()
        }
        .padding(15)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background {
            Rectangle()
                .fill(Color.ikehBackgroundColor)
                .ignoresSafeArea()
        }
    }
    
    // MARK: - Parallax Cards
    
    @ViewBuilder
    func ParallaxCards() -> some View {
        TabView {
            ForEach(sample_places) { place in
                GeometryReader { proxy in
                    let size = proxy.size                    
                    ZStack {
                        Image(place.bgName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    .frame(width: size.width, height: size.height, alignment: .center)
                }
                .padding(.vertical, 30)
                .padding(.horizontal, 40)
            }
            
            
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
    
    // MARK: Tab Bar
    
    @ViewBuilder
    func TabBar() -> some View {
        
        HStack(spacing: 0) {
            ForEach(["house", "suit.heart", "magnifyingglass"], id: \.self) { icon in
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.7))
                    .frame(maxWidth: .infinity)
            }
        }
        
    }
    
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
