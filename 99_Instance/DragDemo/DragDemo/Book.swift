//
//  Book.swift
//  DragDemo
//
//  Created by HIROKI IKEUCHI on 2022/12/30.
//

import Foundation

struct Book: Identifiable {
    let id = UUID()
    var title: String = ["Title2", "Title1", "Title3"].randomElement() ?? ""
    var positon: CGPoint = CGPoint(x: .random(in: 100...300), y: .random(in: 100...600))
}
