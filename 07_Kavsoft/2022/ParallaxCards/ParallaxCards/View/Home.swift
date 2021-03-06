//
//  Home.swift
//  ParallaxCards
//
//  Created by HIROKI IKEUCHI on 2022/07/18.
//

import SwiftUI

struct Home: View {
    
    // MARK: - Properties
    
    // MARK: State object of motion manager
    
    @StateObject var motionManager: MotionMangar = .init()
    
    // MARK: Computed properties
    
    // 上限を決めるだけかな
    private var overlayOffset: CGFloat {
        let offset = motionManager.xValue * 7
        let maxOffset: CGFloat = 8
        if offset > 0 {
            return offset > maxOffset ? maxOffset : offset
        }
        return -offset > maxOffset ? -maxOffset : offset
    }
    
    // MARK: - View
    
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
        TabView(selection: $motionManager.currentSlide) {
            ForEach(sample_places) { place in
                GeometryReader { proxy in
                    let size = proxy.size
                    
                    // MARK: Adding parallax effect to currently showing slide
                    
                    ZStack {
                        Image(place.bgName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .offset(x: motionManager.currentSlide.id == place.id
                                    ? -motionManager.xValue * 75 : 0,
                                    y: 0)
                            .frame(width: size.width, height: size.height, alignment: .center)
                            .clipped()
                        
                        Image(place.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .offset(x: motionManager.currentSlide.id == place.id
                                    ? overlayOffset : 0,
                                    y: 0)
                            .frame(width: size.width, height: size.height, alignment: .center)
                            .clipped()
                            .scaleEffect(1.05, anchor: .bottom)
                        
                        VStack(spacing: 5) {
                            Text("FEATURES")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.white.opacity(0.6))
                            
                            Text(place.placeName)
                                .font(.system(size: 45, weight: .regular, design: .serif))
                                .italic()
                                .foregroundColor(.white.opacity(0.6))
                                .shadow(color: .black.opacity(0.3), radius: 15, x: 5, y: 5)
                                .shadow(color: .black.opacity(0.3), radius: 15, x: -5, y: -5)
                            
                            Button {
                                
                            } label: {
                                Text("EXPLORE")
                                    .font(.system(size: 14, weight: .regular, design: .serif))
                                    .italic()
                                    .foregroundColor(.white.opacity(0.6))
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .background {
                                        ZStack {
                                            Rectangle()
                                                .fill(.black.opacity(0.15))
                                            
                                            Rectangle()
                                                .fill(.white.opacity(0.3))
                                        }
                                    }
                            }
                            .padding(.top, 15)
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top, 60)
                        .offset(x: motionManager.currentSlide.id == place.id
                                ? motionManager.xValue * 15 : 0,
                                y: 0)
                    }
                    .frame(width: size.width, height: size.height, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                    
                    // MARK: If You Need Smooth Animation
                    // It wil1 Consume Some Memory
                    // So Always Check Memory Usage
                    .animation(
                        .interactiveSpring(),
                               value: motionManager.xValue)
                }
                .padding(.vertical, 30)
                .padding(.horizontal, 40)
                .tag(place)
            }
            
            
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .onAppear {
            motionManager.detectMotion()
        }
        .onDisappear {
            motionManager.stopMotionUpdates()
        }
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
