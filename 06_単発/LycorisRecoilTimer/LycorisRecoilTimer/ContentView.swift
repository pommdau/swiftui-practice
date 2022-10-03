//
//  ContentView.swift
//  LycorisRecoilTimer
//
//  Created by HIROKI IKEUCHI on 2022/09/27.
//

import SwiftUI

struct ContentView: View {
    
    let timeRemaining: Duration = .seconds(610.9)
    
    var body: some View {
        durationText()
    }
    
    @ViewBuilder
    private func durationText() -> some View {
        let durationString = timeRemaining.formatted(
            .time(
                pattern: .minuteSecond(padMinuteToLength: 2, fractionalSecondsLength: 2)
            )
        )
        Text(durationString)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
