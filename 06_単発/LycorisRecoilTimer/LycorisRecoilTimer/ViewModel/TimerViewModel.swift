//
//  TimerViewModel.swift
//  LycorisRecoilTimer
//
//  Created by HIROKI IKEUCHI on 2022/09/28.
//

import Foundation

enum TimerState {
    case inReady
    case inProgress
    case isTimerOver
}

final class TimerViewModel: ObservableObject {
            
    @Published var state: TimerState = .inReady
    @Published var remainTime = Time(second: 3)
    @Published var remainTimeBuffer = Time()
    private var timer: Timer? = nil
    private var startTime: TimeInterval = Date.timeIntervalSinceReferenceDate
    
    var timerText: String {
        remainTime.displayText
    }
    
    func rightEyeClicked() {
        switch state {
        case .inReady:
            startTimer()
        case .inProgress:
            pauseTimer()
        case .isTimerOver:
            state = .inReady
        }
    }
    
    private func startTimer() {
        state = .inProgress
        startTime = Date.timeIntervalSinceReferenceDate + remainTime.seconds
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            let remainTime = self.startTime - Date.timeIntervalSinceReferenceDate
            if remainTime <= 0 {
                self.state = .isTimerOver
                self.stopTimer()
            } else {
                // 残り時間の更新
                self.remainTime = Time(seconds: remainTime)
            }
        }
    }
                
    private func pauseTimer() {
        state = .inReady
        stopTimer()
        let remainTime = self.startTime - Date.timeIntervalSinceReferenceDate
        // 残り時間の更新
        self.remainTime = Time(seconds: remainTime)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
