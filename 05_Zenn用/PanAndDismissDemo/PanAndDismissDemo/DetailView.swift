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
    @State private var imageDismissTransition: AnyTransition = .move(edge: .top)
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
                Image("image01")
                    .resizable()
                    .frame(width: 300, height: 300)
//                DetailImageView(
//                    imageName: imageName,
//                    backgroundColorOpacity: $backgroundColorOpacity,
//                    onDismiss: { dismissTransition in
//                        self.dismissTransition = dismissTransition
//                        withAnimation {
//                            showingCanvas = false
//                        }
//                    })
                .zIndex(1)
                .transition(.asymmetric(insertion: .opacity,
                                        removal: imageDismissTransition))
            }
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
