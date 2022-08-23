//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by HIROKI IKEUCHI on 2022/08/08.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    
    @StateObject private var store = ScrumStore()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $store.scrums) {
                    // Save Actions
                    Task {
                        do {
                            try await ScrumStore.save(scrums: store.scrums)
                        } catch {
                            fatalError("Error saving scrums.")
                        }
                    }
                }
            }
            .task {
                do {
                    store.scrums = try await ScrumStore.load()
                } catch {
                    fatalError("Error loading scrums.")
                }
            }
        }
    }
}
