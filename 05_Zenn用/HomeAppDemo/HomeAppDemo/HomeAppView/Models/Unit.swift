//
//  Unit.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/08/10.
//

import Foundation
import CoreGraphics

struct Unit {
    let id = UUID()
    var frame: CGRect = .zero
    var colors: UnitColors
    let icon: String
    
    // Anchorに対する当たり判定用(ニコちゃんマークの大きさ)
    var validFrame: CGRect {
        let length: CGFloat = 40
        let validFrame = CGRect(origin: CGPoint(x: frame.midX - length / 2,
                                                y: frame.midY - length / 2),
                                size: CGSize(width: length, height: length))
        return validFrame
    }
}
