//
//  SubviewsCollection+.swift
//  LoopingCards
//
//  Created by HIROKI IKEUCHI on 2026/01/07.
//

import SwiftUI

extension SubviewsCollection {
    
    // e.g. (by 2): [1, 2, 3, 4, 5] -> [3, 4, 5, 1, 2]
    func rotateFromLeft(by: Int) -> [ForEachSubviewCollection.Element] {
        if isEmpty {
            return []
        }
        let moveIndex = by % count
        let rotatedElements = Array(self[moveIndex...]) + Array(self[0..<moveIndex])
        return rotatedElements
    }
}

extension [SubviewsCollection.Element] {
    func index(_ item: SubviewsCollection.Element) -> Int {
        firstIndex(where: { $0.id == item.id }) ?? 0
    }
}
