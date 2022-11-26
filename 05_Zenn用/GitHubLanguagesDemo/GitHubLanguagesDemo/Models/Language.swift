//
//  Language.swift
//  GitHubLanguagesDemo
//
//  Created by HIROKI IKEUCHI on 2022/11/26.
//

import Foundation

struct Language: Identifiable {
    let name: String
    let amount: Int
    let percentage: Double
    
    var id: String { name }
}

extension Language {
    static var sampleData: [Language] {
        
        // ref: https://api.github.com/repos/robovm/apple-ios-samples/languages
        guard
            let url = Bundle.main.url(forResource: "sample-repository-languages", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let json = try? JSONSerialization.jsonObject(with: data) as? [String: Int]
        else {
            fatalError("sample-repository-languages.jsonの読み込みに失敗しました。")
        }
        
        let sum: Double = json.reduce(0.0) { partialResult, dict in
            let amount = dict.value
            return partialResult + Double(amount)
        }
        
        let languages: [Language] = json.map { name, amount in
            let percentage = max(0.01, Double(amount) / sum)
            return Language(name: name, amount: amount, percentage: percentage)
        }.sorted(by: { first, second in
            // 使用率が大きい順にソート
            first.amount > second.amount
        })
                        
        return languages
    }
}
