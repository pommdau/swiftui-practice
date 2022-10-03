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
    var millisecond: Double
    
    var seconds: Double {
        return Double(minute * 60 + second) + millisecond
    }
    
    init(minute: Int = 0, second: Int = 0, millisecond: Double = 0) {
        self.minute = minute
        self.second = second
        self.millisecond = millisecond
    }
    
    init(seconds: Double) {
        let minute = (Int(seconds) % 3600) / 60
        let second = Int(seconds) % 60
        let millisecond = (seconds - floor(seconds))
        self.minute = minute
        self.second = second
        self.millisecond = millisecond
    }
}
