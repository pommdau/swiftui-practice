//
//  ContentView.swift
//  PhotoTintedShadows
//
//  Created by HIROKI IKEUCHI on 2022/08/23.
//


import SwiftUI

struct ContentView: View {
    
    @State private var playing = true
    
    var Photo: some View = Image("shot")
        .resizable()
        .aspectRatio(contentMode: .fit)
        
    
    var body: some View {
        Photo
            .cornerRadius(64)
            .blur(radius: 15)
//            .offset(x: playing ? 30 : -30)
            .offset(y: playing ? 30 : -30)
            .opacity(1.0)
            .frame(width: 300)
            .overlay(Photo.cornerRadius(12))
            .onTapGesture {
                playing.toggle()
            }
//            .animation(.spring(response: 0.3, dampingFraction: 0.5))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
