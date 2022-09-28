//
//  TimerViewModel.swift
//  LycorisRecoilTimer
//
//  Created by HIROKI IKEUCHI on 2022/09/28.
//

import Foundation

final class TimerViewModel: ObservableObject {
            
    @Published var timerText: String = "xx:xx:xx"
    private var timer: Timer? = nil
    private var startTime: TimeInterval? = Date.timeIntervalSinceReferenceDate + 0.77
    @Published var isTimerValid: Bool = false
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { _ in
            guard let startTime = self.startTime else {
                return
            }
            let remainTime = startTime - Date.timeIntervalSinceReferenceDate
            
            if remainTime <= 0 {
                self.isTimerValid = true
                self.timerText = "TIME UP!"
                self.stopTimer()
            } else {
                let min = Int(remainTime / 60)
                let sec = Int(remainTime) % 60
                let msec = Int((remainTime - Double(sec)) * 100.0)
                self.timerText = String(format: "%02d:%02d:%02d", min, sec, msec)
            }
        })
    }
    
    func stopTimer() {
        self.isTimerValid = false
        timer?.invalidate()
        timer = nil
    }
}
