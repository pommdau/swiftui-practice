//
//  Time.swift
//  LycorisRecoilTimer
//
//  Created by HIROKI IKEUCHI on 2022/09/28.
//

import Foundation

struct Time {
    var hour: Int
    var minute: Int
    var second: Int
    
    var totalSeconds: Double {
        return Double(hour * 3600 + minute * 60 + second)
    }
    
    init(hour: Int = 0, minute: Int = 0, second: Int = 0) {
        self.hour = hour
        self.minute = minute
        self.second = second
    }
    
    init(seconds: Int) {
        let hour = Int(seconds / 3600)
        let minute = (seconds % 3600) / 60
        let second = seconds % 60        
        self.hour = hour
        self.minute = minute
        self.second = second
    }
}
