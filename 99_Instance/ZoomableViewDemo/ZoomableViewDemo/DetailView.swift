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
    var min: CGFloat = 1.0  // TODO: RENAME
    var max: CGFloat = 2.0
    @GestureState private var zoomState = ZoomState.inactive  // ズーム中のスケール
    @State private var currentScale: CGFloat = 1.0  // 現在のスケール

    var trueScale: CGFloat {
        return currentScale * zoomState.scale
    }
    
    // MARK: - Computed Properties
    
    var scrollViewAxes: Axis.Set {
//        return scale > 1.0 ? [.horizontal, .vertical] : []
        return  [.horizontal, .vertical]
    }
    
    var zoomGesture: some Gesture {
        MagnificationGesture()
            .updating($zoomState) { value, referedZoomState, transaction in
                referedZoomState = .active(scale: value)
            }
            .onEnded { value in
                print("onEnded")
                var new = self.currentScale * value
                if new <= min { new = min }
                if new >= max { new = max }
                self.currentScale = new
            }
    }
    
    var doubleTapGesture: some Gesture {
        TapGesture(count: 2).onEnded {
            if trueScale <= min { currentScale = max } else
            if trueScale >= max { currentScale = min } else {
                currentScale = ((max - min) * 0.5 + min) < trueScale ? max : min
            }
        }
    }
    
    // MARK: - LifeCycle
    
    // MARK: - View
    
    public func body(content: Content) -> some View {
        ScrollView(scrollViewAxes, showsIndicators: showsIndicators) {
            content
                .frame(maxWidth: screenSize.width, maxHeight: screenSize.height)
                .scaleEffect(trueScale, anchor: .center)
        }
        .gesture(ExclusiveGesture(zoomGesture, doubleTapGesture))
        .background(.blue)
        .animation(.easeInOut, value: trueScale)
    }
}
