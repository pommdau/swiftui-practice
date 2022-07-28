//
//  RectangleUnitView.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/28.
//

import SwiftUI

struct RectangleUnitView: View {
    
    private let rectangleCornerRadius: CGFloat = 20
    private let rectangleLength: CGFloat = 120
    let color: Color
    var currentColor: Color {
        active ? color : .gray
    }
    @Binding var active: Bool
    
    var body: some View {
        ZStack {
            Frame()
            CenterIcon()
            TopLeftIcon()
        }
    }
    
    @ViewBuilder
    private func Frame() -> some View {
        RoundedRectangle(cornerRadius: rectangleCornerRadius)
            .stroke(currentColor, lineWidth: 4)
            .background(
                RoundedRectangle(cornerRadius: rectangleCornerRadius)
                    .fill(currentColor.opacity(0.5))
            )
            .frame(width: rectangleLength, height: rectangleLength)
    }
    
    @ViewBuilder
    private func CenterIcon() -> some View {
        ZStack {
            Image(systemName: "face.smiling.fill")
                .resizable()
                .foregroundColor(currentColor.opacity(0.6))
                .frame(width: 40, height: 40)
            Image(systemName: "face.smiling")
                .resizable()
                .foregroundColor(currentColor.opacity(1.0))
                .frame(width: 40, height: 40)
        }
    }
    
    @ViewBuilder
    private func TopLeftIcon() -> some View {
        Image(systemName: "drop.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
            .offset(x: -40, y: -30)
            .foregroundColor(.white)
            .shadow(color: .black.opacity(0.3), radius: 2, x: 2, y: 2)
    }
}

struct RectangleUnitView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleUnitView(color: .blue, active: .constant(true))
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
