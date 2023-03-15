//
//  FullScreenPanelDemoApp.swift
//  FullScreenPanelDemo
//
//  Created by HIROKI IKEUCHI on 2023/02/28.
//

import SwiftUI

@main
struct FullScreenPanelDemoApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
