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
    @Published var time = Time(second: 3)
    @Published var timeBuffer = Time()
    private var timer: Timer? = nil
    private var startTime: TimeInterval = Date.timeIntervalSinceReferenceDate
    
    var _remainTime: Time {
        let remainTime = self.startTime - Date.timeIntervalSinceReferenceDate
        if remainTime < 0 {
            return Time(seconds: 0)
        } else {
            return Time(seconds: remainTime)
        }
    }
    
    var timerText: String {
        time.displayText
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
        startTime = Date.timeIntervalSinceReferenceDate + time.seconds
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            let remainTime = self.startTime - Date.timeIntervalSinceReferenceDate
            if remainTime <= 0 {
                self.state = .isTimerOver
                self.stopTimer()
            } else {
                // 残り時間の更新
                self.time = Time(seconds: remainTime)
            }
        }
    }
                
    private func pauseTimer() {
        state = .inReady
        stopTimer()
        let remainTime = self.startTime - Date.timeIntervalSinceReferenceDate
        // 残り時間の更新
        self.time = Time(seconds: remainTime)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
