//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by HIROKI IKEUCHI on 2022/08/08.
//

import SwiftUI

struct ScrumsView: View {
    
    // MARK: - Properties
    
    // MARK: Private Properties
    
    // MARK: Public Properties
    
    let scrums: [DailyScrum]
    
    // MARK: Computed Properties
    
    // MARK: - LifeCycle
    
    // MARK: - View
    
    // MARK: - Helpers
    
    var body: some View {
        List {
            ForEach(scrums) { scrum in
                NavigationLink(destination: Text(scrum.title)) {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
        }
        .navigationTitle("Daily Scrums")
        .toolbar {
            Button(action: {}) {
                Image(systemName: "plus")
            }
            .accessibilityLabel("New Scrum")
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumsView(scrums: DailyScrum.sampleData)
        }
    }
}
