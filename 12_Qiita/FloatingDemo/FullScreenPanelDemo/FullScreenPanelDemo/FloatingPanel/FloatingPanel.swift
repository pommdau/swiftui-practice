//
//  FloatingPanel.swift
//  FloatingWindowDemo
//
//  Created by HIROKI IKEUCHI on 2023/02/27.
//

import SwiftUI


/// An NSPanel subclass that implements floating panel traits.
class FloatingPanel: NSPanel {
    
    init(view: some View,
         contentRect: NSRect,
         backing: NSWindow.BackingStoreType = .buffered,
         defer flag: Bool = true
    ) {
        /// Init the window as usual
        super.init(contentRect: contentRect,
                   styleMask: [.borderless, .nonactivatingPanel],
                   backing: backing,
                   defer: flag)
        
        /// Allow the panel to be on top of other windows
        isFloatingPanel = true
        level = .popUpMenu
        
        /// Allow the pannel to be overlaid in a fullscreen space
        collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        isOpaque = false
        hasShadow = false
        
        /// Don't show a window title, even if it's set
        titleVisibility = .hidden
        titlebarAppearsTransparent = true
        
        /// Since there is no title bar make the window moveable by dragging on the background
        isMovableByWindowBackground = true
        
        /// Hide all traffic light buttons
        standardWindowButton(.closeButton)?.isHidden = true
        standardWindowButton(.miniaturizeButton)?.isHidden = true
        standardWindowButton(.zoomButton)?.isHidden = true
        
        /// Sets animations accordingly
        animationBehavior = .utilityWindow
        
        //        backgroundColor = NSColor(white: 0.0, alpha: 0.02)
        backgroundColor = NSColor(displayP3Red: 0, green: 1.0, blue: 1.0, alpha: 0.3)
                
        /// Set the content view.
        /// The safe area is ignored because the title bar still interferes with the geometry
        contentView = NSHostingView(
            rootView:
                ZStack {
                    Color.clear  // NSPanelの大きさを保つためにダミーのコンテンツが必要
                    view
                }
                .ignoresSafeArea()
                .environment(\.floatingPanel, self) // 今回は使ってなさそう
        )
    }
    
    /// `canBecomeKey` and `canBecomeMain` are both required so that text inputs inside the panel can receive focus
    override var canBecomeKey: Bool {
        return true
    }
    
    override var canBecomeMain: Bool {
        return true
    }
    
}

private struct FloatingPanelKey: EnvironmentKey {
    static let defaultValue: NSPanel? = nil
}

extension EnvironmentValues {
    var floatingPanel: NSPanel? {
        get { self[FloatingPanelKey.self] }
        set { self[FloatingPanelKey.self] = newValue }
    }
}
