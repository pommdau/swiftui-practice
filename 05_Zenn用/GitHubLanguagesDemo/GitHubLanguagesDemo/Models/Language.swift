//
//  Language.swift
//  GitHubLanguagesDemo
//
//  Created by HIROKI IKEUCHI on 2022/11/26.
//

import SwiftUI

struct Language: Identifiable {
    let name: String
    let amount: Int
    let percentage: Double
    let color: Color
    
    var titleForLegend: String {
        "\(name) \((percentage * 100).truncate(places: 1))%"
    }
    
    var id: String { name }
}
