//
//  TransparentWindow.swift
//  FullScreenPanelDemoWithBackground
//
//  Created by HIROKI IKEUCHI on 2023/02/28.
//

import SwiftUI

struct TransparentWindow: NSViewRepresentable {
    
    let screen: Screen
    var didSetFrame: (NSRect) -> Void
    
    func makeNSView(context: Self.Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async {
            
            guard let window = view.window else { return }
                        
//            window.styleMask = [.borderless, .nonactivatingPanel]  // will be crash...
            window.backingType = .buffered

            window.level = .popUpMenu
            window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
            window.isOpaque = false  // 不透明かどうか
            window.hasShadow = false
            window.backgroundColor = NSColor(displayP3Red: 0, green: 1.0, blue: 1.0, alpha: 0.5)
            window.isMovableByWindowBackground = true

            // 左上のボタン
            window.standardWindowButton(.zoomButton)?.isHidden = true
            window.standardWindowButton(.closeButton)?.isHidden = true
            window.standardWindowButton(.miniaturizeButton)?.isHidden = true

            // window.styleMaskを設定しない場合...
            // ①: メニューバーまでの高さまでしか設定されない
            // ②: frame.originがDockの高さだけズレる
            // ![image](https://i.imgur.com/XXcHr3V.png)
            window.setFrame(screen.screenFrame, display: true)
            window.orderFrontRegardless()
            window.identifier = .init(screen.id)
            
            didSetFrame(window.frame)  // 実際のウインドウサイズを返してモデルクラスへ反映させる
        }
        
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) { }
}
