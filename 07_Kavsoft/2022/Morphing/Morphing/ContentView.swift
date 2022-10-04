//
//  ContentView.swift
//  Morphing
//
//  Created by HIROKI IKEUCHI on 2022/10/04.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MorphingView()
            .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
