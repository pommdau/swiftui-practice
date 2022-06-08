//
//  DetailView.swift
//  PanAndDismissDemo
//
//  Created by HIROKI IKEUCHI on 2022/06/08.
//

import SwiftUI

struct DetailView: View {
    let imageName: String
    @Binding var showingModal: Bool
    @State private var imageDismissTransition: AnyTransition = .move(edge: .leading)
    @State private var backgroundColorOpacity: Double = 1.0
    
    var body: some View {
        ZStack {
            if showingModal {
                // 画像周りの背景色
                Color(.black)
                    .ignoresSafeArea()
                    .opacity(backgroundColorOpacity)
                    .transition(.opacity)
            }
            
            if showingModal {
                SwipableImageView(imageName: imageName,
                                  backgroundColorOpacity: $backgroundColorOpacity,
                                  imageDismissTransition: $imageDismissTransition,
                                  onDismiss: {
                    withAnimation {
                        showingModal = false
                    }
                })
                .zIndex(1)
                .transition(.asymmetric(insertion: .opacity,
                                        removal: imageDismissTransition))
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    
    @State static private var showingModal = true
    
    static var previews: some View {
        DetailView(imageName: "image01",
                   showingModal: $showingModal)
    }
}
