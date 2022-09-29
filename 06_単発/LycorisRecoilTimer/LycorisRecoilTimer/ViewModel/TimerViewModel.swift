//
//  TimerViewModel.swift
//  LycorisRecoilTimer
//
//  Created by HIROKI IKEUCHI on 2022/09/28.
//

import Foundation

final class TimerViewModel: ObservableObject {
                
    @Published var isTimeOver: Bool = false
    @Published var time = Time(seconds: 3)
    @Published var timeBuffer = Time()
    
    var timerText: String {
        return String(format: "%02d:%02d:%02d", time.hour, time.minute, time.second)
    }
    
    var isTimerValid: Bool {
        if let timer = timer,
           timer.isValid {
            return true
        } else {
            return false
        }
    }
        
    private var timer: Timer? = nil
    private var startTime: TimeInterval = Date.timeIntervalSinceReferenceDate + 5.0
    
    func rightEyeClicked() {
        startTimer()
    }
    
    private func startTimer() {
        
//        guard isTimerValid else { return }
                
        startTime = Date.timeIntervalSinceReferenceDate + time.totalSeconds
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            let remainTime = self.startTime - Date.timeIntervalSinceReferenceDate
            if remainTime <= 0 {
                self.isTimeOver = true
                self.stopTimer()
            } else {
                self.time = Time(seconds: Int(remainTime))
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
