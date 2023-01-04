//
//  ZoomableView.swift
//  PageCurlDemo
//
//  Created by HIROKI IKEUCHI on 2023/01/03.
//

import SwiftUI

import SwiftUI

public struct ZoomableView<Content>: View where Content: View {
    
    private var size: CGSize
    private var min: CGFloat = 1.0
    private var max: CGFloat = 3.0
    private var showsIndicators: Bool = false
    @ViewBuilder private var content: () -> Content
    
    /**
     Initializes an `ZoomableView`
     - parameter size : The content size of the views.
     - parameter min : The minimum value that can be zoom out.
     - parameter max : The maximum value that can be zoom in.
     - parameter showsIndicators : A value that indicates whether the scroll view displays the scrollable component of the content offset, in a way that’s suitable for the platform.
     - parameter content : The ZoomableView view’s content.
     */
    public init(size: CGSize,
                min: CGFloat = 1.0,
                max: CGFloat = 3.0,
                showsIndicators: Bool = false,
                @ViewBuilder content: @escaping () -> Content) {
        self.size = size
        self.min = min
        self.max = max
        self.showsIndicators = showsIndicators
        self.content = content
    }
    
    public var body: some View {
        content()
            .frame(width: size.width, height: size.height, alignment: .center)
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .contentShape(Rectangle())
            .modifier(ZoomableModifier(contentSize: self.size,
                                       min: min,
                                       max: max,
                                       showsIndicators: showsIndicators))
    }
}
