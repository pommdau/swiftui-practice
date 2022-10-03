//
//  ContentView.swift
//  LycorisRecoilTimer
//
//  Created by HIROKI IKEUCHI on 2022/09/27.
//

import SwiftUI

struct ContentView: View {
    
    enum TimerState {
        case inReady
        case inProgress
        case isTimerOver
    }
    
    @State var timeRemaining: Duration = .seconds(10.1)
    @State private var state: TimerState = .inReady
    @State private var timer: Timer? = nil
    @State private var startTime: TimeInterval = Date.timeIntervalSinceReferenceDate
    
    var body: some View {
        VStack(spacing: 12) {
            stateText()
            durationText()
            Button("Start") {
                timer = nil
                state = .inProgress
                // TODO: エレガントじゃない…
                startTime = Date.timeIntervalSinceReferenceDate
                + Double(timeRemaining.components.seconds)
                + Double(timeRemaining.components.attoseconds) / 100000000000000000.0
                print(timeRemaining.components.attoseconds)
                timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                    let remainTime = self.startTime - Date.timeIntervalSinceReferenceDate
                    self.timeRemaining = .seconds(remainTime)
                    print(remainTime)
                }
            }
        }
    }
    
    @ViewBuilder
    private func stateText() -> some View {
        HStack {
            Text("State:")
            switch state {
            case .inReady:
                Text("inReady")
            case .inProgress:
                Text("inProgress")
            case .isTimerOver:
                Text("isTimerOver")
            }
        }
        
    }
    
    @ViewBuilder
    private func durationText() -> some View {
        let durationString = timeRemaining.formatted(
            .time(
                pattern: .minuteSecond(padMinuteToLength: 2, fractionalSecondsLength: 2)
            )
        )
        Text(durationString)
            .monospacedDigit()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
