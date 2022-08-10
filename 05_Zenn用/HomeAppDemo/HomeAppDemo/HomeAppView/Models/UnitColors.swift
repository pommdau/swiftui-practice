//
//  UnitColors.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/31.
//

import SwiftUI

struct UnitColors: Equatable {
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
    
    static let unit2 = UnitColors(frameStroke: Color(red: 0.884, green: 0.356, blue: 0.367),
                                  frameFill: Color(red: 0.969, green: 0.501, blue: 0.484),
                                  iconStroke: Color(red: 0.798, green: 0.026, blue: 0.000),
                                  iconFill: Color(red: 0.903, green: 0.127, blue: 0.086))
    
    static let unit3 = UnitColors(frameStroke: Color(red: 0.951, green: 0.633, blue: 0.267),
                                  frameFill: Color(red: 0.977, green: 0.721, blue: 0.364),
                                  iconStroke: Color(red: 0.803, green: 0.368, blue: 0.000),
                                  iconFill: Color(red: 0.890, green: 0.488, blue: 0.000))
        
    static let offUnit = UnitColors(frameStroke: Color(red: 0.577, green: 0.553, blue: 0.533),
                                    frameFill: Color(red: 0.723, green: 0.713, blue: 0.713),
                                    iconStroke: Color(red: 0.366, green: 0.354, blue: 0.385),
                                    iconFill: Color(red: 0.460, green: 0.452, blue: 0.473))
}
