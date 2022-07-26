//
//  ContentView.swift
//  CubicBezierFromMathToMotionDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            LinearInterpolationView()
                .padding()
                .tabItem {
                    Image(systemName: "1.circle.fill")
                    Text("Linear")
                }
            Text("Hello, world!")
                .padding()
                .tabItem {
                    Image(systemName: "2.circle.fill")
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
