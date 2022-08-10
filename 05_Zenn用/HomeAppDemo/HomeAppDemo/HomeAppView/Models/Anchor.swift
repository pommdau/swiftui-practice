//
//  Anchor.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/08/01.
//

import CoreGraphics

struct Anchor {
    
    // MARK: - Definition
    
    enum DraggingState {
        case none
        case draggingInputAnchor
        case draggingOutputAnchor
    }

    // MARK: - Properties
    
    var startAnchorFrame: CGRect = CGRect(x: 100, y: 100, width: 60, height: 60)
    var endAnchorFrame: CGRect = CGRect(x: 200, y: 200, width: 60, height: 60)
    var draggingState: DraggingState = .none
    var connectedInputUnitIndex = -1
    var connectedOuputUnitIndex = -1
    
    var isConnected: Bool {
        return connectedInputUnitIndex >= 0 && connectedOuputUnitIndex >= 0
    }
}
