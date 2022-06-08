//
//  ZoomableView.swift
//  ZoomableViewDemo
//
//  Created by HIROKI IKEUCHI on 2022/06/08.
//

import SwiftUI

struct DetailView: View {
    
    let imageName: String
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .modifier(IKEHZoomableModifier(screenSize: geometry.size))
            }
            Text("\(imageName)")
        }
    }
}

struct ZoomableView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(imageName: "image01")
    }
}

public struct IKEHZoomableModifier: ViewModifier {

    // MARK: - Properties
        
    var showsIndicators: Bool = true
    var screenSize: CGSize = .zero
    
    // MARK: - Computed Properties
    
    var scrollViewAxes: Axis.Set {
//        return scale > 1.0 ? [.horizontal, .vertical] : []
        return [.horizontal, .vertical]
    }
    
    // MARK: - LifeCycle
    
    // MARK: - View
    
    public func body(content: Content) -> some View {
        ScrollView(scrollViewAxes, showsIndicators: showsIndicators) {
            content
                .frame(width: screenSize.width, height: screenSize.height)
//                    .frame(width: 200, height: 200, alignment: .center)
//                .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
//                .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
        }
        .background(.red)
    }
}
