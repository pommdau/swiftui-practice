//
//  MeetingTimerView.swift
//  Scrumdinger
//
//  Created by HIROKI IKEUCHI on 2022/08/23.
//

import SwiftUI

struct MeetingTimerView: View {
    
    let speakers: [ScrumTimer.Speaker]
    let theme: Theme
    
    private var currentSpeaker: String {
        // Speakerがいない場合はSomeone
        speakers.first(where: { !$0.isCompleted })?.name ?? "Someone"
    }
    
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                VStack {
                    Text(currentSpeaker)
                        .font(.title)
                    Text("is speaking")
                }
                .accessibilityElement(children: .combine)  // 2つのTextを1つの文として読み上げる設定
                .foregroundColor(theme.accentColor)
            }
    }
}

struct MeetingTimerView_Previews: PreviewProvider {
    
    static var speakers: [ScrumTimer.Speaker] {
        [ScrumTimer.Speaker(name: "Bill", isCompleted: true),
         ScrumTimer.Speaker(name: "Cathy", isCompleted: false)]
    }
    
    static var previews: some View {
        MeetingTimerView(speakers: speakers,
                         theme: .yellow)
    }
}
