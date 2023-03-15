//
//  FloatingPanelController.swift
//  FullScreenPanelDemo
//
//  Created by HIROKI IKEUCHI on 2023/03/07.
//

import Cocoa

class FloatingPanelController: NSWindowController, NSWindowDelegate {
    
    var windowDidMoveHandler: ((NSWindow?) -> ())?
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    func windowDidMove(_ notification: Notification) {
        windowDidMoveHandler?(window)
    }
    
}
