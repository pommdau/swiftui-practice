//
//  SwipableImageView.swift
//  PanAndDismissDemo
//
//  Created by HIROKI IKEUCHI on 2022/06/08.
//

import SwiftUI

struct SwipableImageView: View {
    
    let imageName: String
    @State private var offset: CGSize = .zero
    @Binding var backgroundColorOpacity: Double
    @Binding var imageDismissTransition: AnyTransition
    let dismissThreshold: CGFloat = 150
    var onDismiss: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(uiColor: .clear)
                    .contentShape(Rectangle())
                    .ignoresSafeArea()
                Image(imageName)
                    .resizable()
                    .frame(width: 300, height: 300)
                    .offset(y: offset.height)
                    .animation(.interactiveSpring(), value: offset)
            }
            .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
            .simultaneousGesture(
                DragGesture()
                    .onChanged { gesture in
                        if gesture.translation.width < 50 {
                            offset = gesture.translation
                        }
                        // 画面の高さに対してどれだけスワイプされているかの比率
                        backgroundColorOpacity = 1 - abs(Double(offset.height / geometry.size.height))
                    }
                    .onEnded { _ in
                        if offset.height < -dismissThreshold {
                            imageDismissTransition = .move(edge: .top)
                            onDismiss()
                            backgroundColorOpacity = 1.0
                        } else if offset.height > dismissThreshold {
                            imageDismissTransition = .move(edge: .bottom)
                            onDismiss()
                            backgroundColorOpacity = 1.0
                        } else {
                            offset = .zero
                            backgroundColorOpacity = 1.0
                        }
                    }
            )
        }
    }
}
    
    //struct SwipableImageView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        SwipableImageView()
    //    }
    //}
    //
