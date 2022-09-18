//
//  Person.swift
//  TableViewDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/18.
//

import Foundation

struct Person: Identifiable {
    let givenName: String
    let familyName: String
    let emailAddress: String
    let id = UUID()
}
