//
//  Language.swift
//  GitHubLanguagesDemo
//
//  Created by HIROKI IKEUCHI on 2022/11/26.
//

import Foundation
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

extension Language {
    
    static let otherThresholdPercentage = 0.004  // 0.5%未満をOtherとする
    
    static func createSampleData() -> [Language] {
                                
        // ref: https://api.github.com/repos/robovm/apple-ios-samples/languages
        guard
            let url = Bundle.main.url(forResource: "sample-repository-languages", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let json = try? JSONSerialization.jsonObject(with: data) as? [String: Int]
        else {
            fatalError("sample-repository-languages.jsonの読み込みに失敗しました。")
        }
        
        let sumAmount: Double = json.reduce(0.0) { partialResult, dict in
            let amount = dict.value
            return partialResult + Double(amount)
        }
        
        var languages = [Language]()
        var otherAmount = 0
        var otherPercentage: Double = .zero
        
        for (name, amount) in json {
            let percentage = Double(amount) / sumAmount
            if percentage < otherThresholdPercentage {
                // 一定値以下のものをOtherにまとめる
                otherAmount += amount
                otherPercentage += percentage
                continue
            }
            
            languages.append(
                Language(name: name,
                         amount: amount,
                         percentage: percentage,
                         color: GitHubLanguageColor.shared.getColor(withName: name) ?? .accentColor)
            )
        }
        otherPercentage = max(0.001, otherPercentage)
                                
        languages.sort(by: { first, second in
            // 使用率が大きい順にソート
            first.amount > second.amount
        })
        
        if otherPercentage > 0 {
            languages.append(
                Language(name: "Other",
                         amount: otherAmount,
                         percentage: otherPercentage,
                         color: .otherLanguage)
            )
        }
                        
        return languages
    }
}
