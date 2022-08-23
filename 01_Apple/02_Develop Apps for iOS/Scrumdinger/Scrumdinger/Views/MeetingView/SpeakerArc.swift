//
//  SpeakerArc.swift
//  Scrumdinger
//
//  Created by HIROKI IKEUCHI on 2022/08/23.
//

import SwiftUI

struct SpeakerArc: Shape {
    
    let speakerIndex: Int
    let totalSpeakers: Int
    
    private var degreePerSpeaker: Double {
        360.0 / Double(totalSpeakers)
    }
    
    private var startAngle: Angle {
        // +1.0は視覚的な分離用
        Angle(degrees: degreePerSpeaker * Double(speakerIndex) + 1.0)
    }
    
    private var endAngle: Angle {
        Angle(degrees: startAngle.degrees + degreePerSpeaker - 1.0)
    }
    
    // MARK: - Public
    
    func path(in rect: CGRect) -> Path {
        // 座標系は左下が原点
        let diameter = min(rect.size.width, rect.size.height) - 24.0
        let radius = diameter / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        return Path { path in
            path.addArc(center: center,
                        radius: radius,
                        startAngle: startAngle,
                        endAngle: endAngle,
                        clockwise: false)
        }
    }
}

