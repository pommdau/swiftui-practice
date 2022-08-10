//
//  UnitView.swift
//  HomeAppDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/31.
//

import SwiftUI

struct UnitView: View {
    
    private let rectangleCornerRadius: CGFloat = 20
    private let rectangleLength: CGFloat = 120
    let icon: String
    @Binding var unitColors: UnitColors
    
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
            .stroke(unitColors.frameStroke, lineWidth: 2)
            .background(
                RoundedRectangle(cornerRadius: rectangleCornerRadius)
                    .fill(unitColors.frameFill)
            )
            .frame(width: rectangleLength, height: rectangleLength)
        
        // Shadow
        // 直接.shadowをつけるとstrokeが浮かび上がってしまうため
        RoundedRectangle(cornerRadius: rectangleCornerRadius)
            .foregroundColor(.black.opacity(0.3))
            .frame(width: rectangleLength, height: rectangleLength)
            .offset(x: 0, y: 4)
            .blur(radius: 4)
            .zIndex(-1)
    }
    
    @ViewBuilder
    private func CenterIcon() -> some View {
        ZStack {
//            Image(systemName: "poweroutlet.type.f")  // iOS 16+
            Image(systemName: "face.smiling.fill")
                .resizable()
                .foregroundColor(unitColors.iconFill)
                .frame(width: 40, height: 40)
//            Image(systemName: "poweroutlet.type.f.fill")  // iOS 16+
            Image(systemName: "face.smiling")
                .resizable()
                .foregroundColor(unitColors.iconStroke)
                .frame(width: 40, height: 40)
        }
    }
    
    @ViewBuilder
    private func TopLeftIcon() -> some View {
        Image(systemName: icon)
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
            .offset(x: -36, y: -36)
            .foregroundColor(.white)
            .shadow(color: .black.opacity(0.3), radius: 2, x: 2, y: 2)
    }
}

struct RectangleUnitView_Previews: PreviewProvider {
    static var previews: some View {
        UnitView(icon: "drop.fill", unitColors: .constant(.unit2))
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
