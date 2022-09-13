//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by HIROKI IKEUCHI on 2022/07/10.
//

import SwiftUI

@main
struct LandmarksApp: App {
    
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
        
        #if !os(watchOS)
        .commands {
            LandmarkCommands()
        }
        #endif
        
        #if os(watchOS)
        WKNotificationScene(controller: NotificationController.self, category: "LandmarkNear")
        #endif
        
        #if os(macOS)
        // 設定はmacOSのみ
        Settings {
            LandmarkSettings()
        }
        #endif
    }
}
