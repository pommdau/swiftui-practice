//
//  RopeView.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/31.
//

import SwiftUI

struct RopeView: View {
    
    
    
    var body: some View {
        TimelineView(.periodic(from: Date(), by: 1/60)) { context in
            Rope()
        }
    }
    
    @ViewBuilder
    private func Rope() -> some View {
        Path { path in
            path.move(to: CGPoint(x: 100, y: 100))
            path.addQuadCurve(to: CGPoint(x: 300, y: 100),
                              control: CGPoint(x: 200, y: 200))
        }
        .stroke(lineWidth: 6)
        .foregroundStyle(
            .linearGradient(
                colors: [.pink, .blue, .pink],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .shadow(color: .black.opacity(1.0), radius: 8, x: 0, y: 15)
    }
}

struct RopeView_Previews: PreviewProvider {
    static var previews: some View {
        RopeView()
    }
}
