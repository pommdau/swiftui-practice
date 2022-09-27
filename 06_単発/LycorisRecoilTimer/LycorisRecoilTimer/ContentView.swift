//
//  ContentView.swift
//  LycorisRecoilTimer
//
//  Created by HIROKI IKEUCHI on 2022/09/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack {            
            Color.red
                .ignoresSafeArea()
            VStack {
                Text("PUNISHMENT")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                HStack(alignment: .center) {
                    Robot()
                }
                .foregroundColor(.black)
                .padding()
                
                Text("EXPLOSION!!!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
