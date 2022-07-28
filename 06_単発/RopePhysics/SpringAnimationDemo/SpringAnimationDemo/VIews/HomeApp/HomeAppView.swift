//
//  HomeAppView.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/27.
//

import SwiftUI


struct HomeAppView: View {
        
    @State private var isActive = false
    
    var body: some View {
        HStack(spacing: 140) {
            
            Toggle(isOn: $isActive.animation()) {
                Text("Toggle me!")
            }
            
            VStack(spacing: 20) {
                RectangleUnitView(color: .blue, active: $isActive)
//                RectangleUnit(color: .blue)
//                RectangleUnit(color: .red)
//                RectangleUnit(color: .orange)
            }
            
            VStack(spacing: 20) {
//                RectangleUnit(color: .blue)
//                RectangleUnit(color: .red)
//                RectangleUnit(color: .orange)
            }
        }
    }
    
}

struct HomeAppView_Previews: PreviewProvider {
    static var previews: some View {
        HomeAppView()
    }
}
