//
//  StartUnit.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/08/01.
//

import CoreGraphics
import Foundation

struct StartUnit {
    let id = UUID().uuidString
    var frame: CGRect = .zero
    let colors: UnitColors
    let icon: String
    var validFrame: CGRect {
        let length: CGFloat = 40  // 当たり判定: ニコちゃんマークの大きさ
        let validFrame = CGRect(origin: CGPoint(x: frame.midX - length / 2,
                                                y: frame.midY - length / 2),
                                size: CGSize(width: length, height: length))
        return validFrame
    }
}

