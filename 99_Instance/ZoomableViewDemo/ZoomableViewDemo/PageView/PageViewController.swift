//
//  PageViewController.swift
//  TransitionDemo
//
//  Created by HIROKI IKEUCHI on 2022/06/07.
//

import SwiftUI
import UIKit

// これはSwiftUIのクラス
// UIViewControllerRepresentable: SwiftUIでUIKitを使うためのもの
struct PageViewController<Page: View>: UIViewControllerRepresentable {
    var pages: [Page]
    @Binding var currentPage: Int
    
    // MARK: - UIViewControllerRepresentable Delegate
    
    // 作成したいUIViewControllerを返す
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)

        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        
        return pageViewController
    }
    
    // updateUIViewController: 必須のメソッド。Viewが更新された場合に必要な処理を実装する
    // UIHostingController: SwiftUIのViewをUIKitで使えるViewに変換？
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers(
            [context.coordinator.controllers[currentPage]],
            direction: .forward,
            animated: true)
    }
}

// MARK: - Coordinator

extension PageViewController {
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: PageViewController  // PageViewControllerの参照を持って間接的に処理を行う感じかな
        var controllers = [UIViewController]()
        
        init(_ pageViewController: PageViewController) {
            parent = pageViewController
            // UIHostingController: SwiftUIのViewをUIKitのViewに変換？
            controllers = parent.pages.map { UIHostingController(rootView: $0) }
        }
        
        // MARK: - UIPageViewControllerDataSource
        
        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerBefore viewController: UIViewController) -> UIViewController?
        {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index == 0 {
                return controllers.last
            }
            return controllers[index - 1]
        }
        
        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerAfter viewController: UIViewController) -> UIViewController?
        {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index + 1 == controllers.count {
                return controllers.first
            }
            return controllers[index + 1]
        }
        
        // MARK: - UIPageViewControllerDelegate
        
        func pageViewController(
            _ pageViewController: UIPageViewController,
            didFinishAnimating finished: Bool,
            previousViewControllers: [UIViewController],
            transitionCompleted completed: Bool) {
                if completed,
                   let visibleViewController = pageViewController.viewControllers?.first,
                   let index = controllers.firstIndex(of: visibleViewController) {
                    parent.currentPage = index
                }
            }
    }
    
    //    extension Coordinator: UIPageViewControllerDataSource {
    //
    //    }
    
}
