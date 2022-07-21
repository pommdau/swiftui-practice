//
//  Home.swift
//  WavesAnimation_2021-06-13
//
//  Created by HIROKI IKEUCHI on 2022/07/21.
//

import SwiftUI

struct Home: View {
    var body: some View {
        ZStack {
            // Wave form view...
            WaveForm(color: .purple, amplify: 150)
        }
        .ignoresSafeArea(.all, edges: .bottom)        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .previewDevice("iPhone 13 Pro Max")
    }
}

struct WaveForm: View {
    
    var color: Color
    var amplify: CGFloat
    
    var body: some View {
        // Using time line view for peroidc updates...
        
        TimelineView(.animation) { timeLine in
            
            // Canvas View for drawding wave...
            Canvas { context, size in
                // getting current time
                let timeNow = timeLine.date.timeIntervalSinceReferenceDate
                
                // Using SwiftUI path for drawing wave...
                context.fill(
                    Path { path in
                        let midHeight = size.height / 2
                        let width = size.width
                        
                        // moving the wave to center leading
                        path.move(to: CGPoint(x: 0, y: midHeight))
                                                
                        // drawing curve...
                        path.addCurve(
                            to: CGPoint(x: width, y: midHeight),
                            control1: CGPoint(x: width * 0.5, y: midHeight + amplify),
                            control2: CGPoint(x: width * 0.5, y: midHeight - amplify))
                        
                        // filling the bottom remaining
                        path.addLine(to: CGPoint(x: width, y: size.height))
                        path.addLine(to: CGPoint(x: 0, y: size.height))
                    }, with: .color(color))
            }
        }
    }
}
