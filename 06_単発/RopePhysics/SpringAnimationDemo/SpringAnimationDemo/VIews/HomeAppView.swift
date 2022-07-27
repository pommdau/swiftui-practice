//
//  HomeAppView.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/27.
//

import SwiftUI

struct HomeAppView: View {
    
    private let rectangleCornerRadius: CGFloat = 20
    private let rectangleLength: CGFloat = 120
    
    var body: some View {
        HStack(spacing: 140) {
            VStack(spacing: 20) {
                RectangleUnit(color: .blue)
                RectangleUnit(color: .red)
                RectangleUnit(color: .orange)
            }
            
            VStack(spacing: 20) {
                RectangleUnit(color: .blue)
                RectangleUnit(color: .red)
                RectangleUnit(color: .orange)
            }
        }
    }
    
    @ViewBuilder
    private func RectangleUnit(color: Color) -> some View {
        ZStack {
                        
            RoundedRectangle(cornerRadius: rectangleCornerRadius)
                .stroke(color, lineWidth: 4)
                .background(
                    RoundedRectangle(cornerRadius: rectangleCornerRadius)
                        .fill(color.opacity(0.5))
                )
                .frame(width: rectangleLength, height: rectangleLength)
            
            ZStack {
                Image(systemName: "face.smiling.fill")
                    .resizable()
                    .foregroundColor(color.opacity(0.6))
                    .frame(width: 40, height: 40)
                Image(systemName: "face.smiling")
                    .resizable()
                    .foregroundColor(color.opacity(1.0))
                    .frame(width: 40, height: 40)
            }
            
        }
    }
}

struct HomeAppView_Previews: PreviewProvider {
    static var previews: some View {
        HomeAppView()
    }
}
