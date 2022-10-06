//
//  Tab.swift
//  DynamicTabIndicator
//
//  Created by HIROKI IKEUCHI on 2022/10/06.
//

import Foundation

struct Tab: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var tabName: String
    var sampleImage: String
    
    static func sampleTabs() -> [Tab] {
        [
            .init(tabName: "Iceland", sampleImage: "Image1"),
            .init(tabName: "France", sampleImage: "Image2"),
            .init(tabName: "Brazil", sampleImage: "Image3"),
        ]
    }
}
