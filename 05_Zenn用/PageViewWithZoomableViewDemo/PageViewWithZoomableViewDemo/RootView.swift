//
//  ZoomableContentView.swift
//  TransitionDemo
//
//  Created by HIROKI IKEUCHI on 2022/06/06.
//

import SwiftUI

struct RootView: View {
    
    @State private var showingModal = false
    @State private var selectedImageIndex = 0
    private let photos = [Photo.mock1, Photo.mock2, Photo.mock3, Photo.mock4]
    
    var body: some View {
        
        ZStack {
            if showingModal {
                GeometryReader { geometry in
                    PageView(
                        pages: photos.map({ photo in
                            ZoomableView(viewSize: photo.size,
                                         screenSize: geometry.size) {
                                Image(photo.name)
                                    .resizable()
                                    .scaledToFit()
                                    .clipped()
                            }
                        }),
                        currentPage: selectedImageIndex
                    )
                }
                .modifier(PanAndDismissModifier(showingModal: $showingModal,
                                                backgroundColor: .gray))
                .zIndex(1)
                
            }
            
            VStack {
                HStack {
                    Button {
                        selectedImageIndex = 0
                        withAnimation() {
                            showingModal = true
                        }
                    } label: {
                        Image(photos[0].name)
                            .resizable()
                            .scaledToFit()
                    }
                    Button {
                        selectedImageIndex = 1
                        withAnimation() {
                            showingModal = true
                        }
                    } label: {
                        Image(photos[1].name)
                            .resizable()
                            .scaledToFit()
                    }
                }
                HStack {
                    Button {
                        selectedImageIndex = 2
                        withAnimation() {
                            showingModal = true
                        }
                    } label: {
                        Image(photos[2].name)
                            .resizable()
                            .scaledToFit()
                    }
                    Button {
                        selectedImageIndex = 3
                        withAnimation() {
                            showingModal = true
                        }
                    } label: {
                        Image(photos[3].name)
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
        }
    }
}

struct RootViewView_Preview: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
