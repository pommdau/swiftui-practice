//
//  Sticky.swift
//  PageCurlDemo
//
//  Created by HIROKI IKEUCHI on 2022/12/29.
//

import SwiftUI

class Sticky: ObservableObject {
    
    @Published var message: String
    @Published var positon: CGPoint
    
    let darkColor: Color = .stickyDarkGreen
    let lightColor: Color = .stickyLightGreen
    
    init(message: String, positon: CGPoint) {
        self.message = message
        self.positon = positon
    }
}
