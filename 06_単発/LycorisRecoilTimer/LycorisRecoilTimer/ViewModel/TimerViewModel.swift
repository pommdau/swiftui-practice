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
    private var startTime: TimeInterval = Date.timeIntervalSinceReferenceDate + 5.0
    
    func rightEyeClicked() {
        startTimer()
    }
    
    private func startTimer() {
        
        // タイマーがすでに動いている場合は一時停止
        if timer != nil {
            stopTimer()
            let remainTime = self.startTime - Date.timeIntervalSinceReferenceDate
            self.time = Time(seconds: remainTime)
            return
        }
                
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
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
