//
//  TCADemo2App.swift
//  TCADemo2
//
//  Created by HIROKI IKEUCHI on 2024/02/13.
//

import ComposableArchitecture
import SwiftUI

@main
struct TCADemo2App: App {
    
    // Storeの作成は一回だけ
    // ほとんどはアプリのルートに作成してOK
    // storeには初期状態を渡す
    static let store = Store(initialState: AppFeature.State()) {
        // Closure内で機能を提供するReducerを指定
        AppFeature()
//            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            AppView(store: TCADemo2App.store)
        }
    }
}
