//
//  TimerViewModel.swift
//  LycorisRecoilTimer
//
//  Created by HIROKI IKEUCHI on 2022/09/28.
//

import Foundation

final class TimerViewModel: ObservableObject {
                
    @Published var isTimeOver: Bool = false
    @Published var time = Time(second: 3)
    @Published var timeBuffer = Time()
    
    var timerText: String {
        return String(format: "%02d:%02d:%02d", time.minute, time.second, Int(time.millisecond * 100))
    }
        
    private var timer: Timer? = nil
    private var startTime: TimeInterval = Date.timeIntervalSinceReferenceDate
    
    func rightEyeClicked() {
        if let _ = timer {
            pauseTimer()
        } else {
            startTimer()
        }
    }
    
    private func startTimer() {
        isTimeOver = false
        startTime = Date.timeIntervalSinceReferenceDate + time.totalSeconds
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            let remainTime = self.startTime - Date.timeIntervalSinceReferenceDate
            if remainTime <= 0 {
                self.isTimeOver = true
                self.stopTimer()
            } else {
                self.time = Time(seconds: remainTime)
            }
        }
    }
    
    private func pauseTimer() {
        stopTimer()
        let remainTime = self.startTime - Date.timeIntervalSinceReferenceDate
        self.time = Time(seconds: remainTime)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
