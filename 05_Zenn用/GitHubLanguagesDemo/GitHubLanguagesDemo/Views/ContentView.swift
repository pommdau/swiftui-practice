//
//  ContentView.swift
//  GitHubLanguagesDemo
//
//  Created by HIROKI IKEUCHI on 2022/11/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            LanguagesBar()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
