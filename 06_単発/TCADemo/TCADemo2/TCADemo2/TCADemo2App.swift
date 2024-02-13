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
    
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            CounterView(store: TCADemo2App.store)
        }
    }
}
