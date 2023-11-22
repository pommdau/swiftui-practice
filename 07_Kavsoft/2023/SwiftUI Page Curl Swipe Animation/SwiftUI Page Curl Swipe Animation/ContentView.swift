//
//  ContentView.swift
//  SwiftUI Page Curl Swipe Animation
//
//  Created by HIROKI IKEUCHI on 2023/09/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Home()
                .navigationTitle("Peel Effect")
        }
    }
}

#Preview {
    ContentView()
}
