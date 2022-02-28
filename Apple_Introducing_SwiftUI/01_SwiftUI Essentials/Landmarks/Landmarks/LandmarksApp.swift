//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by HIROKI IKEUCHI on 2022/02/27.
//

import SwiftUI

@main  // @main: entry point identifier
struct LandmarksApp: App {
    @StateObject private var modelData = ModelData()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
