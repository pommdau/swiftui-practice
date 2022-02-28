//
//  ContentView.swift
//  Landmarks
//
//  Created by HIROKI IKEUCHI on 2022/02/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
