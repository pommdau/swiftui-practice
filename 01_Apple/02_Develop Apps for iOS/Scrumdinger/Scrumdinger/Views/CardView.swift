//
//  CardView.swift
//  Scrumdinger
//
//  Created by HIROKI IKEUCHI on 2022/08/08.
//

import SwiftUI

struct CardView: View {
    
    // MARK: - Properties
    
    // MARK: Private Properties
    
    // MARK: Public Properties
    
    let scrum: DailyScrum
    
    // MARK: Computed Properties
    
    // MARK: - LifeCycle
    
    // MARK: - View
    
    // MARK: - Helpers
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(scrum.title)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)  // trait: 性質
            Spacer()
            HStack {
                Label("\(scrum.attendees.count)", systemImage: "person.3")
                    .accessibilityLabel("\(scrum.attendees.count) attendees")
                Spacer()
                Label("\(scrum.lengthInMinutes)", systemImage: "clock")
                    .accessibilityLabel("\(scrum.lengthInMinutes) minute meeting")
                    .labelStyle(.trailingIcon)
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
    }
}

struct CardView_Previews: PreviewProvider {
    
    static var scrum = DailyScrum.sampleData[0]
    
    static var previews: some View {
        CardView(scrum: scrum)
            .background(scrum.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
