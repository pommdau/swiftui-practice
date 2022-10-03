//
//  CGSize.swift
//  LycorisRecoilTimer
//
//  Created by HIROKI IKEUCHI on 2022/09/28.
//

import Foundation

func + (left: CGSize, right: CGSize) -> CGSize {
    return CGSize(width: left.width + right.width, height: left.height + right.height)
}

func += (left: inout CGSize, right: CGSize) {
    left = left + right
}

func - (left: CGSize, right: CGSize) -> CGSize {
    return CGSize(width: left.width - right.width, height: left.height - right.height)
}

func -= (left: inout CGSize, right: CGSize) {
    left = left - right
}

func * (left: CGFloat, right: CGSize) -> CGSize {
    return CGSize(width: left * right.width, height: left * right.height)
}

func * (left: CGSize, right: CGFloat) -> CGSize {
    return CGSize(width: right * left.width, height: right * left.height)
}

func *= (left: inout CGSize, right: CGFloat) {
    left = left * right
}

func / (left: CGSize, right: CGFloat) -> CGSize {
    assert(right != 0, "divide by zero")
    return CGSize(width: left.width / right, height: left.height / right)
}

func /= (left: inout CGSize, right: CGFloat) {
    assert(right != 0, "divide by zero")
    left = left / right
}

extension CGSize {
    // widthとheightの大きさが同じ時の初期化
    init(_ side: CGFloat) {
        self.init(width: side, height: side)
    }
}
