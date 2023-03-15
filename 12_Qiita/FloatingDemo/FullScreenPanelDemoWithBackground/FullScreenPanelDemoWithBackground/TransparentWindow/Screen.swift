//
//  Screen.swift
//  FullScreenPanelDemoWithBackground
//
//  Created by HIROKI IKEUCHI on 2023/02/28.
//

import SwiftUI

struct Screen: Identifiable {
    let id: String
    let localizedName: String
    let screenFrame: CGRect
    var floatingPanelFrame: CGRect
    
    init(screen: NSScreen, floatingPanelFrame: CGRect) {
        self.id = screen.displayID
        self.localizedName = screen.localizedName
        self.screenFrame = screen.frame
        self.floatingPanelFrame = floatingPanelFrame
    }
}

extension Screen {
    static func sampleData() -> Screen {
        let screen = NSScreen.screens.first!
        return Screen(screen: screen, floatingPanelFrame: screen.frame)
    }
}

