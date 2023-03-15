//
//  FullScreenPanelDemoWithBackgroundApp.swift
//  FullScreenPanelDemoWithBackground
//
//  Created by HIROKI IKEUCHI on 2023/02/28.
//

import SwiftUI

@main
struct FullScreenPanelDemoWithBackgroundApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var screenStore = ScreenStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(screenStore)
        }
        
        WindowGroup("FloatingWindowGroup", for: Screen.ID.self) { $screenID in
            if let screenID,
               let screenIndex = screenStore.screens.firstIndex(where: { $0.id == screenID }) {
                ScreenView(screen: screenStore.screens[screenIndex])
                    .background(TransparentWindow(screen: screenStore.screens[screenIndex], didSetFrame: { frame in
                        // 初回配置時のframeの取得
                        screenStore.screens[screenIndex].floatingPanelFrame = NSRectToCGRect(frame)
                    }))
                    .onReceive(NotificationCenter.default.publisher(for: NSWindow.didResizeNotification)) { notification in
                        handleNSWindowNotification(screenIndex: screenIndex,
                                                   notification: notification)
                    }
                    .onReceive(NotificationCenter.default.publisher(for: NSWindow.didMoveNotification)) { notification in
                        handleNSWindowNotification(screenIndex: screenIndex,
                                                   notification: notification)
                    }
            }
        }
        .windowStyle(.hiddenTitleBar)  // タイトルバーを隠す
    }
}

extension FullScreenPanelDemoWithBackgroundApp {
    
    func handleNSWindowNotification(screenIndex: Int, notification: NotificationCenter.Publisher.Output) {
        guard let window = notification.object as? NSWindow else {
            return
        }
        if window.identifier?.rawValue == $screenStore.screens[screenIndex].id {
            screenStore.screens[screenIndex].floatingPanelFrame = NSRectToCGRect(window.frame)
        }
    }
    
}
