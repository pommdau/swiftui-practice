//
//  ContentView.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/26.
//

import SwiftUI

struct ContentView: View {

    private let standardHeight: CGFloat = 400
    
    var body: some View {

        GeometryReader { geomerry in
            Path { path in
                path.move(to: CGPoint(x: 0, y: standardHeight))
                path.addLine(to: CGPoint(x: geomerry.size.width,
                                         y: standardHeight))
            }
            .stroke(lineWidth: 2)
            .foregroundColor(.gray.opacity(0.3))
        }
        
        
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
