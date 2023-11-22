//
//  NotesAppApp.swift
//  NotesApp
//
//  Created by HIROKI IKEUCHI on 2023/11/22.
//

import SwiftUI
import SwiftData

@main
struct NotesAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 300, minHeight: 400)
        }
        .windowResizability(.contentSize)
        /// Adding Data Model to the App
        .modelContainer(for: [Note.self, NoteCategory.self])
    }
}
