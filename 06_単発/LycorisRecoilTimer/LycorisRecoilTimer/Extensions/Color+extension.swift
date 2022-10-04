//
//  Color+extension.swift
//  LycorisRecoilTimer
//
//  Created by HIROKI IKEUCHI on 2022/09/27.
//

import SwiftUI

extension Color {
    
    static func body(state: TimerState) -> Color {
        switch state {
        case .inReady, .inProgress:
            return .black
        case .isTimerOver:
            return .white
        }
    }
    
    static func primaryText(state: TimerState) -> Color {
        switch state {
        case .inReady, .inProgress:
            return .white
        case .isTimerOver:
            return .black
        }
    }
    
    static func eye(state: TimerState) -> Color {
        switch state {
        case .inReady:
            return Color(red: 0.296, green: 0.995, blue: 0.036)
        case .inProgress:
            return Color(red: 0.387, green: 0.904, blue: 0.909)
        case .isTimerOver:
            return Color(red: 0.876, green: 0.172, blue: 0.926)
        }
    }
    
    static func background(state: TimerState) -> Color {
        switch state {
        case .inReady:
            return Color(red: 0.296, green: 0.995, blue: 0.036)
        case .inProgress:
            return Color(red: 0.786, green: 0.200, blue: 0.014)
        case .isTimerOver:
            return Color(red: 0.786, green: 0.200, blue: 0.014)
        }
    }
    
}

