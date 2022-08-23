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
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $store.scrums) {
                    // Save Actions
                    Task {
                        do {
                            try await ScrumStore.save(scrums: store.scrums)
                        } catch {
                            errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                        }
                    }
                }
            }
            .task {
                do {
                    store.scrums = try await ScrumStore.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "Scrumdinger will load sample data and continue.")
                }
            }
            // item($errorWrapper) != nilのときにsheetを表示
            .sheet(item: $errorWrapper,
                   onDismiss: {
                // In the onDismiss closure, assign sample data to the scrums array. Load sample data when the user dismisses the modal.
                store.scrums = DailyScrum.sampleData
            }) { wrapper in
                // content
                ErrorView(errorWrapper: wrapper)
            }


        }
    }
}
