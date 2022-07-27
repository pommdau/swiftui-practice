//
//  GlowEffectView.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/27.
//

import SwiftUI

struct GlowEffectView: View {
    
    @State var isGlowing : Bool = true
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Toggle(isOn: $isGlowing) {
                    Text("Glowing")
                        .foregroundColor(.white)
                }
                .frame(width: 120)
                
                ZStack {
                    Text("")
                        .fontWeight(.bold)
                        .font(.system(size: 180))
                        .foregroundColor(.white)
                        .blur(radius: isGlowing ? 15.0 : 0)
                    Text("")
                        .fontWeight(.bold)
                        .font(.system(size: 180))
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct GlowEffectView_Previews: PreviewProvider {
    static var previews: some View {
        GlowEffectView()
    }
}
