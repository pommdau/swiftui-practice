//
//  CGPoint+covert.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/08/04.
//

import CoreGraphics

extension CGPoint {
    
    func convert(inCanvasSize canvasSize: CGSize) -> CGPoint {
        return CGPoint(x: canvasSize.width * self.x,
                       y: canvasSize.height * self.y)
    }
}

