//
//  ContentView.swift
//  PanAndDismissDemo
//
//  Created by HIROKI IKEUCHI on 2022/06/08.
//

import SwiftUI

struct ContentView: View {
    
    private let imageName = "image01"
    @State private var showingModal = false
    
    var body: some View {
        
        ZStack {
            if showingModal {
                Image("image01")
                    .resizable()
                    .frame(width: 200, height: 200)
//                ZoomedImageView(imageName: imageName,
//                                showingCanvas: $showingModal)
                .zIndex(1)
            }
            Button {
                withAnimation() {
                    showingModal = true
                }
            } label: {
                Image(imageName)
                    .resizable()
                    .frame(width: 200, height: 200)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
