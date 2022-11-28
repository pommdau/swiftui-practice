//
//  LanguagesBar.swift
//  GitHubLanguagesDemo
//
//  Created by HIROKI IKEUCHI on 2022/11/26.
//

import SwiftUI
import Charts

struct LanguagesBar: View {
    
    let languages = Language.createSampleData()
    
    var body: some View {
        Chart {
            ForEach(Array(languages.enumerated()), id: \.element.name) { index, language in
                BarMark(
                    x: .value("Percentage", language.percentage)
                )
                .foregroundStyle(language.color)
                
                RectangleMark(
                    x: .value("padding", calculatePaddingXPosition(at: index)),
                    width: 4
                )
                .foregroundStyle(
                    (index == languages.count - 1) ? .clear : .otherLanguage
                )
            }
        }
        .chartPlotStyle { plotArea in
            plotArea
                .frame(height: 10)
                .cornerRadius(5)
        }
        .chartXAxis(.hidden)
        //        // ref: [New in SwiftUI 4: Charts \(Bar chart\)](https://medium.com/devtechie/new-in-swiftui-4-charts-bar-chart-f242698b04f4)
        .chartForegroundStyleScale(
            domain: languages.map { $0.titleForLegend },
            range: languages.map { $0.color }
        )
    }
    
    private func calculatePaddingXPosition(at index: Int) -> Double {
        if index == languages.count - 1 {
            return .zero
        }
        
        var xPosition: Double = .zero
        for markIndex in 0...index {
            xPosition += languages[markIndex].percentage
        }
        
        return xPosition
    }
    
}

struct LanguagesBar_Previews: PreviewProvider {
    static var previews: some View {
        LanguagesBar()
            .padding()
            .previewLayout(.fixed(width: 400, height: 200))
    }
}
