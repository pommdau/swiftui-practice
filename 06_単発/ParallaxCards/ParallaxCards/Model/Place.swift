//
//  Place.swift
//  ParallaxCards
//
//  Created by HIROKI IKEUCHI on 2022/07/18.
//

import Foundation

// MARK: - Place odel and sample data

struct Place: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var placeName: String
    var imageName: String
    var bgName: String
}

var sample_places: [Place] = [
    .init(placeName: "france", imageName: "france", bgName: "france-bg"),
    .init(placeName: "iceland", imageName: "iceland", bgName: "iceland-bg"),
    .init(placeName: "rio", imageName: "rio", bgName: "rio-bg"),
]
