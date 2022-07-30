//
//  Color+extension.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/29.
//

import SwiftUI

struct UnitColor {
    let frameStroke: Color
    let frameFill: Color
    let iconStroke: Color
    let iconFill: Color
}

extension UnitColor {
    static let unit1 = UnitColor(frameStroke: Color(red: 0.244, green: 0.551, blue: 0.950),
                                 frameFill: Color(red: 0.373, green: 0.659, blue: 0.986),
                                 iconStroke: Color(red: 0.109, green: 0.271, blue: 0.730),
                                 iconFill: Color(red: 0.152, green: 0.377, blue: 0.903))
}

extension Color {        
    static let fillAnchor = Color(uiColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
    static let strokeAnchor = Color(uiColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
    static let fillUnit1 = Color(uiColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
    static let strokeUnit1 = Color(uiColor: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
    static let fillUnit2 = Color(uiColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
    static let strokeUnit2 = Color(uiColor: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1))
    static let fillUnit3 = Color(uiColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
    static let strokeUnit3 = Color(uiColor: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))
}
