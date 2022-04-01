//
//  Stateful.swift
//  TweetImageWithSwiftUIDemo
//
//  Created by HIROKI IKEUCHI on 2022/04/01.
//

import Foundation

enum Stateful<Value> {
    case idle
    case loading
    case failed(Error)
    case loaded(Value)
}
