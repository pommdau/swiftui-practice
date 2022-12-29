import SwiftUI
import UIKit

/// A paging view that generates user-defined static pages.
@available(iOS 13.0, *)
public struct Pages: View {

    @Binding var currentPage: Int
    var pages: [AnyView]

    var navigationOrientation: UIPageViewController.NavigationOrientation
    var transitionStyle: UIPageViewController.TransitionStyle
    var bounce: Bool
    var wrap: Bool
    var hasControl: Bool
    var pageControl: UIPageControl? = nil
    var controlAlignment: Alignment
    var onDelete: () -> ()

    public init(
        currentPage: Binding<Int>,
        navigationOrientation: UIPageViewController.NavigationOrientation = .horizontal,
        transitionStyle: UIPageViewController.TransitionStyle = .scroll,
        bounce: Bool = true,
        wrap: Bool = false,
        hasControl: Bool = true,
        control: UIPageControl? = nil,
        controlAlignment: Alignment = .bottom,
        onDelete: @escaping () -> () = {},
        @PagesBuilder pages: () -> [AnyView]
    ) {
        self.navigationOrientation = navigationOrientation
        self.transitionStyle = transitionStyle
        self.bounce = bounce
        self.wrap = wrap
        self.hasControl = hasControl
        self.pageControl = control
        self.controlAlignment = controlAlignment
        self.onDelete = onDelete
        self.pages = pages()
        self._currentPage = currentPage        
    }

    public var body: some View {
        ZStack(alignment: self.controlAlignment) {
            PageViewController(
                currentPage: $currentPage,
                navigationOrientation: navigationOrientation,
                transitionStyle: transitionStyle,
                bounce: bounce,
                wrap: wrap,
                onDelete: onDelete,
                controllers: pages.map {
                    let h = UIHostingController(rootView: $0)
                    h.view.backgroundColor = .clear
                    return h
                }
            )
            if self.hasControl {
                PageControl(
                    numberOfPages: pages.count,
                    pageControl: pageControl,
                    currentPage: $currentPage
                ).padding()
            }
        }
    }
}
