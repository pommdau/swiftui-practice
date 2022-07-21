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
            .previewInterfaceOrientation(.portrait)
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
                                
                // animating the wave using current time...
                let angle = timeNow.remainder(dividingBy: 2)  // 2で割ったときの余り(純粋な余りではなく、飛び越えて負の値にもなる)
                // calculating offset
                let offset = angle * size.width
                
                context.draw(Text("\(angle)"),
                             at: CGPoint(x: size.width / 2, y: 200))
                context.draw(Text("\(offset)"),
                             at: CGPoint(x: size.width / 2, y: 100))
                
                // you can see it now shifts to screen width...
                
                // you can see it moves between -1.5 - 1.5...
                // ie 3/2 = 1.5
                // if 2 means -1 to 1...
                                
                // moving the whole view...
                // simple and easy wave animation
                context.translateBy(x: offset, y: 0)
                
                // Using SwiftUI path for drawing wave...
                context.fill(getPath(size: size), with: .color(color))
                
                // drawing curve front and back
                // so that translation will be look like wave animation...
                context.translateBy(x: -size.width, y: 0)
                
                context.fill(getPath(size: size), with: .color(color))
                
                context.translateBy(x: size.width * 2, y: 0)
                
                context.fill(getPath(size: size), with: .color(color))
                
            }
        }
    }
    
    private func getPath(size: CGSize) -> Path {
        return Path { path in
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
        }
    }
}
