//
//  View+blurText.swift
//  LycorisRecoilTimer
//
//  Created by HIROKI IKEUCHI on 2022/09/27.
//

import SwiftUI

extension View {
    func blurText(radius: CGFloat) -> some View {
        ZStack {
            self
            self.blur(radius: radius)
        }
    }
}

struct CustomLabelModify: View {
    
    var body: some View {
        ZStack{
            Color.black
            Group{
                Text("Following")
                    .addGlowEffect(color1: Color(Color.RGBColorSpace.sRGB, red: 96/255, green: 252/255, blue: 255/255, opacity: 1), color2: Color(Color.RGBColorSpace.sRGB, red: 44/255, green: 158/255, blue: 238/255, opacity: 1), color3: Color(Color.RGBColorSpace.sRGB, red: 0/255, green: 129/255, blue: 255/255, opacity: 1))
            }
        }
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        CustomLabelModify()
    }
}


extension View {
func addGlowEffect(color1:Color, color2:Color, color3:Color) -> some View {
    self
        .foregroundColor(Color(hue: 0.5, saturation: 0.8, brightness: 1))
        .background {
            self
                .foregroundColor(color1).blur(radius: 0).brightness(0.8)
        }
        .background {
            self
                .foregroundColor(color2).blur(radius: 4).brightness(0.35)
        }
        .background {
            self
                .foregroundColor(color3).blur(radius: 2).brightness(0.35)
        }
        .background {
            self
                .foregroundColor(color3).blur(radius: 12).brightness(0.35)
            
        }
     }
  }
