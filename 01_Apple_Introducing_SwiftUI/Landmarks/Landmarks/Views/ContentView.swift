//
//  ContentView.swift
//  Landmarks
//
//  Created by HIROKI IKEUCHI on 2022/07/10.
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
