//
//  LandmarkList.swift
//  Landmarks
//
//  Created by HIROKI IKEUCHI on 2022/02/27.
//

import SwiftUI

struct LandmarkList: View {
    var body: some View {
        
        List(landmarks) { landmark in
            LandmarkRow(landmark: landmark)
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList()
    }
}
