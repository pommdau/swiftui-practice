//
//  TextInfo.swift
//  GitHubClientPlayground
//
//  Created by HIROKI IKEUCHI on 2022/03/29.
//

import SwiftUI

struct TextInfo: Identifiable {
    var id: Int  // for Identifiable
    var text: String = "あのイーハトーヴォの透き通った風"
    var fontWeight: Font.Weight
    var fontSize = CGFloat(12)
}
