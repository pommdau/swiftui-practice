//
//  Sticky.swift
//  PageCurlDemo
//
//  Created by HIROKI IKEUCHI on 2022/12/29.
//

import SwiftUI

class StickyList: ObservableObject {
    
    @Published var stickies: [Sticky] = []
    
    func add(sticky: Sticky) {
        self.stickies.append(sticky)
    }
    
    func remove(sticky: Sticky) {
        guard let index = stickies.firstIndex(where: { sticky.id == $0.id }) else {
            return
        }
        self.stickies.remove(at: index)
    }
    
    func remove(at index: Int) {
        if index > stickies.count - 1 {
            return
        }
        self.stickies.remove(at: index)
    }
    
}

struct Sticky {
    let id = UUID()
    var currentPageIndex: Int = 0
    var message: String
    var positon: CGPoint
    
    let darkColor: Color = .stickyDarkGreen
    let lightColor: Color = .stickyLightGreen
    
    init(message: String, positon: CGPoint) {
        self.message = message
        self.positon = positon
    }
}
