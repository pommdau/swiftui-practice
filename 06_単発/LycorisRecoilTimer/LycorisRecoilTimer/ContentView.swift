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
                    .lineLimit(1)
                    .font(.system(size: 100))
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.01)
                    .foregroundColor(.white)
                    .glowEffect(radius: 8)
                    .padding(.horizontal)
                
                Robot()
                    .padding(.horizontal)
                
                Text("EXPLOSION!!!")
                    .lineLimit(1)
                    .font(.system(size: 100))
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.01)
                    .foregroundColor(.white)
                    .glowEffect(radius: 8)
                    .padding(.horizontal)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


