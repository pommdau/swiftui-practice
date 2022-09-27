//
//  HalfCircle.swift
//  LycorisRecoilTimer
//
//  Created by HIROKI IKEUCHI on 2022/09/27.
//

import SwiftUI

struct HalfCircle: View {
    var body: some View {
        
        GeometryReader { geometry in
            Path { path in
                let width = min(geometry.size.width, geometry.size.height)
                path.addArc(center: .init(x: width, y: width),
                            radius: width * 1.0,
                            startAngle: Angle(degrees: -90),
                            endAngle: Angle(degrees: 90), clockwise: true)
            }
        }
        
//        Path { path in
//            path.move(to: CGPoint(x: 200, y: 200))
//            path.addArc(center: CGPoint(x: 200, y: 200),
//                        radius: 100,
//                        startAngle: Angle(degrees: -90),
//                        endAngle: Angle(degrees: 90),
//                        clockwise: true)
//        }
    }
}

struct HalfCircle_Previews: PreviewProvider {
    static var previews: some View {
        HalfCircle()
    }
}
