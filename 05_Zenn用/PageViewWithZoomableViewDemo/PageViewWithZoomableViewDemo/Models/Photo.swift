//
//  Photo.swift
//  PageViewWithZoomableViewDemo
//
//  Created by HIROKI IKEUCHI on 2022/06/21.
//

import Foundation
import SwiftUI

struct Photo {
    let name: String
    let size: CGSize
}

// MARK: - Mock

extension Photo {
    static let mock1: Photo = Photo(name: "image01", size: CGSize(width: 800, height: 800))
    static let mock2: Photo = Photo(name: "image02", size: CGSize(width: 600, height: 600))
    static let mock3: Photo = Photo(name: "image03", size: CGSize(width: 1920, height: 1080))
    static let mock4: Photo = Photo(name: "image04", size: CGSize(width: 53, height: 16))
}
