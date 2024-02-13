//
//  TCADemoApp.swift
//  TCADemo
//
//  Created by HIROKI IKEUCHI on 2024/02/08.
//

import ComposableArchitecture
import SwiftUI


@main
struct TCADemoApp: App {
    
    // Storeの作成は一回だけ
    // ほとんどはアプリのルートに作成してOK
    static let store = Store(initialState: AppFeature.State()) {
        AppFeature()
            ._printChanges()
      }
    
    var body: some Scene {
        WindowGroup {
            AppView(store: TCADemoApp.store)
        }
    }
}
