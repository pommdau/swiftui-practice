//
//  Time.swift
//  LycorisRecoilTimer
//
//  Created by HIROKI IKEUCHI on 2022/09/28.
//

import Foundation

struct Time {
    var minute: Int
    var second: Int
    var millisecond: Int
    
    var totalSeconds: Double {
        return Double(minute * 60 + second + millisecond / 60)
    }
    
    init(minute: Int = 0, second: Int = 0, millisecond: Int = 0) {
        self.minute = minute
        self.second = second
        self.millisecond = millisecond
    }
    
    init(seconds: Double) {
        let minute = (Int(seconds) % 3600) / 60
        let second = Int(seconds) % 60
        let millisecond = Int( (seconds - floor(seconds)) * 100)
        
        self.minute = minute
        self.second = second
        self.millisecond = millisecond
    }
}
