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
            .foregroundStyle(GitHubLanguageColor.shared.getColor(withName: language.name) ?? .accentColor)
//            .foregroundStyle(by: .value("Language", language.name))
//            .foregroundStyle(by:
//                    .value(
//                        "Language Category",
//                        "\(language.name) \((language.percentage * 100).truncate(places: 1))%"
//                    )
//            )
        }
        .chartPlotStyle { plotArea in
            plotArea
                .frame(height: 20)
        }
        .chartXAxis(.hidden)
        // ref: [New in SwiftUI 4: Charts \(Bar chart\)](https://medium.com/devtechie/new-in-swiftui-4-charts-bar-chart-f242698b04f4)
        .chartForegroundStyleScale(
            domain: languages.map { $0.name },
            range: languages.map { language in
                GitHubLanguageColor.shared.getColor(withName: language.name) ?? .accentColor
            }
        )
        
    }
    
    
}

struct LanguagesBar_Previews: PreviewProvider {
    static var previews: some View {
        LanguagesBar()
            .padding()
    }
}
