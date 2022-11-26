//
//  LanguagesBar.swift
//  GitHubLanguagesDemo
//
//  Created by HIROKI IKEUCHI on 2022/11/26.
//

import SwiftUI
import Charts

struct LanguagesBar: View {
    
    let languages = Language.sampleData
    
    var body: some View {
        Chart(languages) { language in
            BarMark(
                x: .value("Amount", language.percentage)
            )
            .foregroundStyle(by:
                    .value(
                        "Language Category",
                        "\(language.name) \((language.percentage * 100).truncate(places: 2))%"
                    )
            )
        }
        .frame(height: 200)
    }
}

struct LanguagesBar_Previews: PreviewProvider {
    static var previews: some View {
        LanguagesBar()
            .padding()
    }
}
