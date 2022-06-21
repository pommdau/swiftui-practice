//
//  ZoomableContentView.swift
//  TransitionDemo
//
//  Created by HIROKI IKEUCHI on 2022/06/06.
//

import SwiftUI

struct ZoomableContentView: View {
    
    @State private var showingModal = false
    private let imageName = "image01"
    
    var body: some View {
        
        ZStack {
            
            if showingModal {
                GeometryReader { geometry in
                    PageView(pages: [
                        ZoomableView(viewSize: CGSize(width: 800, height: 800),
                                     screenSize: geometry.size) {
                                         Image("image01")
                                             .resizable()
                                             .scaledToFit()
                                             .clipped()
                                     },
                        ZoomableView(viewSize: CGSize(width: 800, height: 800),
                                     screenSize: geometry.size) {
                                         Image("image02")
                                             .resizable()
                                             .scaledToFit()
                                             .clipped()
                                     },
                        ZoomableView(viewSize: CGSize(width: 800, height: 800),
                                     screenSize: geometry.size) {
                                         Image("image03")
                                             .resizable()
                                             .scaledToFit()
                                             .clipped()
                                     },
                        ZoomableView(viewSize: CGSize(width: 800, height: 800),
                                     screenSize: geometry.size) {
                                         Image("image04")
                                             .resizable()
                                             .scaledToFit()
                                             .clipped()
                                     }
                    ])
                }
                .modifier(PanAndDismissModifier(showingModal: $showingModal,
                                                backgroundColor: .gray))
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

struct ZoomableContentView_Preview: PreviewProvider {
    static var previews: some View {
        ZoomableContentView()
    }
}
