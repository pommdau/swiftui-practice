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
        DetailView(imageName: "image02")
    }
}

public struct IKEHZoomableModifier: ViewModifier {

    // MARK: - Enum
    
    private enum ZoomState {
        case inactive
        case active(scale: CGFloat)
        
        var scale: CGFloat {
            switch self {
            case .active(let scale):
                return scale
            default: return 1.0
            }
        }
    }
    
    // MARK: - Properties
    
    var showsIndicators: Bool = true
    var screenSize: CGSize = .zero
    var minScale: CGFloat = 1.0
    var maxScale: CGFloat = 3.0
    @GestureState private var zoomState = ZoomState.inactive  // ズーム中のスケール
    @State private var currentScale: CGFloat = 1.0  // 現在のスケール

    // MARK: - Computed Properties
    
    var trueScale: CGFloat {
        return currentScale * zoomState.scale
    }
        
    var scrollViewAxes: Axis.Set {
        return trueScale > 1.0 ? [.horizontal, .vertical] : []
    }
    
    var zoomGesture: some Gesture {
        MagnificationGesture()
            .updating($zoomState) { value, referedZoomState, transaction in
                referedZoomState = .active(scale: value)
            }
            .onEnded { value in
                var newScale = self.currentScale * value
                if newScale <= minScale { newScale = minScale }
                if newScale >= maxScale { newScale = maxScale }
                self.currentScale = newScale
                
                print("🐱\(screenSize)")
                print("\(trueScale)")
            }
    }
    
    var doubleTapGesture: some Gesture {
        TapGesture(count: 2).onEnded {
            if trueScale <= minScale { currentScale = maxScale } else
            if trueScale >= maxScale { currentScale = minScale } else {
                currentScale = ((maxScale - minScale) * 0.5 + minScale) < trueScale ? maxScale : minScale
            }
        }
    }
    
    // MARK: - LifeCycle
    
    // MARK: - View
    
    public func body(content: Content) -> some View {
        ScrollView(scrollViewAxes, showsIndicators: showsIndicators) {
            content
                .frame(maxWidth: screenSize.width * trueScale,
                       maxHeight: screenSize.height * trueScale,
                       alignment: .center)
                .scaleEffect(trueScale, anchor: .center)
        }
        .gesture(ExclusiveGesture(zoomGesture, doubleTapGesture))
        .animation(.easeInOut, value: trueScale)
    }
}
