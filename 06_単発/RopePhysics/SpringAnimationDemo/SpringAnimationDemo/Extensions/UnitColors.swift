//
//  UnitColors.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/29.
//

import SwiftUI

struct UnitColors {
    let frameStroke: Color
    let frameFill: Color
    let iconStroke: Color
    let iconFill: Color
}

extension UnitColors {
    static let unit1 = UnitColors(frameStroke: Color(red: 0.244, green: 0.551, blue: 0.950),
                                 frameFill: Color(red: 0.373, green: 0.659, blue: 0.986),
                                 iconStroke: Color(red: 0.109, green: 0.271, blue: 0.730),
                                 iconFill: Color(red: 0.152, green: 0.377, blue: 0.903))
        
    static let offUnit = UnitColors(frameStroke: Color(red: 0.577, green: 0.553, blue: 0.533),
                                    frameFill: Color(red: 0.723, green: 0.713, blue: 0.713),
                                    iconStroke: Color(red: 0.366, green: 0.354, blue: 0.385),
                                    iconFill: Color(red: 0.460, green: 0.452, blue: 0.473))
}
