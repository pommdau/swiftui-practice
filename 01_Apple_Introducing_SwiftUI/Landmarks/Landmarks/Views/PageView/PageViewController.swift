//
//  PageViewController.swift
//  Landmarks
//
//  Created by HIROKI IKEUCHI on 2022/08/02.
//

import SwiftUI
import UIKit

struct PageViewController<Page: View>: UIViewControllerRepresentable {
    var pages: [Page]
    
    // 一度だけ初期化時に呼ばれる
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)

        return pageViewController
    }
    
    // Updates the state of the specified view controller with new information from SwiftUI.
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers(
            [UIHostingController(rootView: pages[0])], direction: .forward, animated: true)
    }
    

}
