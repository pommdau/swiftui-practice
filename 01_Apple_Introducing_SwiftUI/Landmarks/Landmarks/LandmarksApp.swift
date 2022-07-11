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
    }
}
