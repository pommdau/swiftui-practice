//
//  ContentView.swift
//  TouchAnimation
//
//  Created by HIROKI IKEUCHI on 2022/08/15.
//

import SwiftUI

enum AnimationEffect {
    case one
    case two
    case three
}

struct ContentView: View {
        
    @State private var animationEffect: AnimationEffect = .one
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Animation Effect")
                    Spacer()
                }
                Picker(selection: $animationEffect, label: Text("Animation"), content: {
                    Text("Animation 1").tag(AnimationEffect.one)
                    Text("Animation 2").tag(AnimationEffect.two)
                    Text("Animation 3").tag(AnimationEffect.three)
                })
                .pickerStyle(SegmentedPickerStyle())
            }
            Spacer()
            Home(animationEffect: $animationEffect)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
