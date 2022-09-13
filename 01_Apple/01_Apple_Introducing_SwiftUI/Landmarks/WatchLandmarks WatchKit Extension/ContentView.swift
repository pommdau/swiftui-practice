//
//  ContentView.swift
//  WatchLandmarks WatchKit Extension
//
//  Created by HIROKI IKEUCHI on 2022/09/13.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
