//
//  Landmark.swift
//  Landmarks
//
//  Created by HIROKI IKEUCHI on 2022/02/27.
//

import Foundation
import SwiftUI
import CoreLocation

struct Landmark: Hashable, Codable {
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String
    
    // MARK: - Image
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
    
    // MARK: - Corrdinates
    
    private var coordinates: Coordinates
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
    
}
