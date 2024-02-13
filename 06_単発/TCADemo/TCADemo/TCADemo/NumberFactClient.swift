//
//  NumberFactClient.swift
//  TCADemo
//
//  Created by HIROKI IKEUCHI on 2024/02/13.
//

import Foundation
import ComposableArchitecture

/*
 プロトコルは依存関係インターフェイスを抽象化する最も一般的な方法ですが、プロトコルが唯一の方法ではありません。
 インターフェイスを表すために可変プロパティを持つ構造体を使用し、適合性を表すために構造体の値を構築することを好みます。
 必要に応じて依存関係にプロトコルを使用できますが、構造体のスタイルについて詳しく知りたい場合は、
 一連のビデオで詳細を参照してください
 */
struct NumberFactClient {
    var fetch: (Int) async throws -> String
}

extension NumberFactClient: DependencyKey {
    static let liveValue = Self(
        fetch: { number in
            let (data, _) = try await URLSession.shared
                .data(from: URL(string: "http://numbersapi.com/\(number)")!)
            return String(decoding: data, as: UTF8.self)
        }
    )
}

extension DependencyValues {
    var numberFact: NumberFactClient {
        get { self[NumberFactClient.self] }
        set { self[NumberFactClient.self] = newValue }
    }
}
