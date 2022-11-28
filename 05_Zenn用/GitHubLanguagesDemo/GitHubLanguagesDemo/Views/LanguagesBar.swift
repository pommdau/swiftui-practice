//
//  LanguagesBar.swift
//  GitHubLanguagesDemo
//
//  Created by HIROKI IKEUCHI on 2022/11/26.
//

import SwiftUI
import Charts

struct LanguagesBar: View {
    
//    let languages = Language.sampleData
    let languages = Language.createSampleData()
    
    var body: some View {
        Chart(languages) { language in
            BarMark(
                x: .value("Percentage", language.percentage)
            )
            .foregroundStyle(language.color)
        }
        .chartPlotStyle { plotArea in
            plotArea
                .frame(height: 10)
                .clipShape (
                    RoundedRectangle(cornerRadius:5, style: .continuous)
                )
        }
        .chartXAxis(.hidden)
        // ref: [New in SwiftUI 4: Charts \(Bar chart\)](https://medium.com/devtechie/new-in-swiftui-4-charts-bar-chart-f242698b04f4)
        .chartForegroundStyleScale(
            domain: languages.map { $0.titleForLegend },
            range: languages.map { $0.color }
        )
    }
}

struct LanguagesBar_Previews: PreviewProvider {
    static var previews: some View {
        LanguagesBar()
            .padding()
            .previewLayout(.fixed(width: 400, height: 200))
    }
}
