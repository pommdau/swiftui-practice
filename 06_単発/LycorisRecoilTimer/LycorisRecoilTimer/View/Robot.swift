//
//  Robot.swift
//  LycorisRecoilTimer
//
//  Created by HIROKI IKEUCHI on 2022/09/27.
//

import SwiftUI

struct Robot: View {
    
    let timerString: String
    let isTimeOver: Bool
    var leftEyeTapped: () -> () = {}
    var rightEyeTapped: () -> () = {}
    
    private static func calculateOffsetY(viewHeight: CGFloat, svgHeight: CGFloat) -> CGFloat {
        if viewHeight > svgHeight {
            return (viewHeight / 2) - (svgHeight / 2)
        } else {
            return .zero
        }
    }
    
    var body: some View {
                
        GeometryReader { geometry in
            let width = min(geometry.size.width, geometry.size.height)
            let scale = width / Self.svgSize.width
            let offset = CGSize(width: 0,
                                height: Self.calculateOffsetY(viewHeight: geometry.size.height,
                                                              svgHeight: (Self.svgSize * scale).height))
            Circle()
                .foregroundColor(isTimeOver ? .robotPinkEye : .robotBlueEye)
                .glowEffect(radius: 6)
                .frame(width: width * 0.18)
                .position(x: width * 0.32, y: width * 0.29 + offset.height)
                .onTapGesture {
                    leftEyeTapped()                    
                }
            
            Circle()
                .foregroundColor(isTimeOver ? .robotPinkEye : .robotBlueEye)
                .glowEffect(radius: 6)
                .frame(width: width * 0.18)
                .position(x: width * 0.69, y: width * 0.29 + offset.height)
                .onTapGesture {
                    rightEyeTapped()
                }
            
            timerText()
                .frame(width: width * 0.58)
                .offset(x: width * 0.21, y: width * 0.41 + offset.height)
            
            robotBodyText(viewWidth: width, offset: offset)
            
            createRobotPath(scale: scale, offset: offset)
                .fill(isTimeOver ? .white : .black)
                .zIndex(-1)
        }
    }
}

extension Robot {
    
    @ViewBuilder
    private func timerText() -> some View {
        if isTimeOver {
            Text(timerString)
                .lineLimit(1)
                .font(.system(size: 100, weight: .light).monospacedDigit())
                .minimumScaleFactor(0.01)
                .foregroundColor(.black)
        } else {
            Text(timerString)
                .lineLimit(1)
                .font(.system(size: 100, weight: .light).monospacedDigit())
                .minimumScaleFactor(0.01)
                .glowEffect(radius: 8)
                .foregroundColor(.white)
        }
    }
    
    @ViewBuilder
    private func robotBodyText(viewWidth width: CGFloat, offset: CGSize) -> some View {
        if isTimeOver {
            Text("TIME UP!")
                .lineLimit(1)
                .font(.system(size: 100))
                .fontWeight(.light)
                .minimumScaleFactor(0.01)
                .foregroundColor(.red)
                .frame(width: width * 0.30)
                .offset(x: width * 0.35, y: width * 0.73 + offset.height)
        } else {
            Text("PLEASE ENJOY\nTHE PARTY!")
                .glowEffectText(lineLimit: 2)
                .frame(width: width * 0.55)
                .offset(x: width * 0.23, y: width * 0.68 + offset.height)
        }
    }
    
}

struct Robot_Previews: PreviewProvider {
    static var previews: some View {
        
        Robot(timerString: "15:86:10",
              isTimeOver: false)
        .background(.red)
        .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
                   .previewDisplayName("iPhone 12")

        Robot(timerString: "15:86:10",
              isTimeOver: true)
        .background(.red)
        .frame(width: 400, height: 600)

    }
}

extension CGPoint {
    
    func convert(scale: CGFloat = 1.0, offset: CGSize = .zero) -> CGPoint {
        return CGPoint(x: self.x * scale + offset.width,
                       y: self.y * scale + offset.height)
    }
}

extension Robot {
    
    static let svgSize = CGSize(width: 200, height: 232.48)
    
    func createDebugPath(scale: CGFloat) -> Path {
        
        //        let offset = CGSize(width: 100, height: 200)
        let offset: CGSize = .zero
        
        return Path { path in
            path.move(to: .init(x: 0, y: 0).convert(scale: scale, offset: offset))
            path.addLine(to: .init(x: 0, y: 100).convert(scale: scale, offset: offset))
            path.addLine(to: .init(x: 100, y: 100).convert(scale: scale, offset: offset))
            path.addLine(to: .init(x: 100, y: 0).convert(scale: scale, offset: offset))
            path.addLine(to: .init(x: 0, y: 0).convert(scale: scale, offset: offset))
        }
    }
    
    func createRobotPath(scale: CGFloat, offset: CGSize) -> Path {
                
        return Path { path in
            path.move(to: CGPoint(x: 36.0400, y: 0.5000).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 164.6500, y: 0.5000).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 164.6500, y: 118.2900).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 36.0400, y: 118.2900).convert(scale: scale, offset: offset))
            path.closeSubpath()
            path.move(to: CGPoint(x: 164.1500, y: 1.0000).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 164.1500, y: 117.7900).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 36.5400, y: 117.7900).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 36.5400, y: 1.0000).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 164.1500, y: 1.0000).convert(scale: scale, offset: offset))
            path.move(to: CGPoint(x: 165.1500, y: 0.0000).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 35.5400, y: 0.0000).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 35.5400, y: 118.7900).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 165.1500, y: 118.7900).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 165.1500, y: 0.0000).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 165.1500, y: 0.0000).convert(scale: scale, offset: offset))
            path.closeSubpath()
            path.move(to: CGPoint(x: 29.8900, y: 86.6700).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 8.8500, y: 59.2300).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 18.2700, y: 86.6700).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 8.8500, y: 74.3900).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 29.8900, y: 31.7900).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 8.8500, y: 44.0700).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 18.2700, y: 31.7900).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 29.8900, y: 86.6600).convert(scale: scale, offset: offset))
            path.closeSubpath()
            path.move(to: CGPoint(x: 56.8300, y: 186.3300).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 36.2300, y: 123.8100).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 164.4400, y: 123.8100).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 142.4900, y: 186.3300).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 56.8300, y: 186.3300).convert(scale: scale, offset: offset))
            path.closeSubpath()
            path.move(to: CGPoint(x: 163.7400, y: 124.3100).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 142.1400, y: 185.8300).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 57.1900, y: 185.8300).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 36.9200, y: 124.3100).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 163.7300, y: 124.3100).convert(scale: scale, offset: offset))
            path.move(to: CGPoint(x: 165.1400, y: 123.3100).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 35.5400, y: 123.3100).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 56.4700, y: 186.8300).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 142.8500, y: 186.8300).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 165.1500, y: 123.3100).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 165.1500, y: 123.3100).convert(scale: scale, offset: offset))
            path.closeSubpath()
            path.move(to: CGPoint(x: 169.4700, y: 31.8000).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 190.5100, y: 59.2400).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 181.0900, y: 31.8000).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 190.5100, y: 44.0800).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 169.4700, y: 86.6800).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 190.5100, y: 74.4000).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 181.0900, y: 86.6800).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 169.4700, y: 31.8000).convert(scale: scale, offset: offset))
            path.closeSubpath()
            path.move(to: CGPoint(x: 59.8300, y: 192.2500).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 91.0600, y: 192.2500).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 91.0600, y: 211.6700).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 59.8300, y: 211.6700).convert(scale: scale, offset: offset))
            path.closeSubpath()
            path.move(to: CGPoint(x: 90.5700, y: 192.7500).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 90.5700, y: 211.1700).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 60.3400, y: 211.1700).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 60.3400, y: 192.7500).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 90.5700, y: 192.7500).convert(scale: scale, offset: offset))
            path.move(to: CGPoint(x: 91.5700, y: 191.7500).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 59.3300, y: 191.7500).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 59.3300, y: 212.1700).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 91.5600, y: 212.1700).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 91.5600, y: 191.7500).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 91.5600, y: 191.7500).convert(scale: scale, offset: offset))
            path.closeSubpath()
            path.move(to: CGPoint(x: 56.6200, y: 215.8400).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 94.2800, y: 215.8400).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 94.2800, y: 231.8700).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 56.6200, y: 231.8700).convert(scale: scale, offset: offset))
            path.closeSubpath()
            path.move(to: CGPoint(x: 93.7800, y: 216.3400).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 93.7800, y: 231.3700).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 57.1200, y: 231.3700).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 57.1200, y: 216.3400).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 93.7800, y: 216.3400).convert(scale: scale, offset: offset))
            path.move(to: CGPoint(x: 94.7800, y: 215.3400).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 56.1200, y: 215.3400).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 56.1200, y: 232.3700).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 94.7800, y: 232.3700).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 94.7800, y: 215.3400).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 94.7800, y: 215.3400).convert(scale: scale, offset: offset))
            path.closeSubpath()
            path.move(to: CGPoint(x: 109.5600, y: 192.3700).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 140.7900, y: 192.3700).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 140.7900, y: 211.7900).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 109.5600, y: 211.7900).convert(scale: scale, offset: offset))
            path.closeSubpath()
            path.move(to: CGPoint(x: 140.2900, y: 192.8700).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 140.2900, y: 211.2900).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 110.0600, y: 211.2900).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 110.0600, y: 192.8700).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 140.2900, y: 192.8700).convert(scale: scale, offset: offset))
            path.move(to: CGPoint(x: 141.2900, y: 191.8700).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 109.0600, y: 191.8700).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 109.0600, y: 212.2900).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 141.2900, y: 212.2900).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 141.2900, y: 191.8700).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 141.2900, y: 191.8700).convert(scale: scale, offset: offset))
            path.closeSubpath()
            path.move(to: CGPoint(x: 106.3500, y: 215.9500).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 144.0100, y: 215.9500).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 144.0100, y: 231.9800).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 106.3500, y: 231.9800).convert(scale: scale, offset: offset))
            path.closeSubpath()
            path.move(to: CGPoint(x: 143.5100, y: 216.4500).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 143.5100, y: 231.4800).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 106.8500, y: 231.4800).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 106.8500, y: 216.4500).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 143.5100, y: 216.4500).convert(scale: scale, offset: offset))
            path.move(to: CGPoint(x: 144.5100, y: 215.4500).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 105.8500, y: 215.4500).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 105.8500, y: 232.4800).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 144.5100, y: 232.4800).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 144.5100, y: 215.4500).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 144.5100, y: 215.4500).convert(scale: scale, offset: offset))
            path.closeSubpath()
            path.move(to: CGPoint(x: 194.5700, y: 165.1000).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 180.1100, y: 165.3300).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 180.1800, y: 168.6600).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 180.2300, y: 166.6800).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 180.2300, y: 167.8100).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 166.1300, y: 185.1300).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 172.2200, y: 169.9200).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 166.1300, y: 176.8200).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 166.3200, y: 187.6400).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 166.1300, y: 185.9800).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 166.1900, y: 186.8200).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 176.1200, y: 187.6400).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 175.6700, y: 185.1300).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 175.8300, y: 186.8600).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 175.6700, y: 186.0100).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 182.8200, y: 177.9800).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 175.6700, y: 181.1800).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 178.8700, y: 177.9800).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 189.9700, y: 185.1300).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 186.7700, y: 177.9800).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 189.9700, y: 181.1800).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 187.3200, y: 190.6800).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 189.9700, y: 187.3700).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 188.9400, y: 189.3700).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 187.3200, y: 190.6800).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 194.2200, y: 197.3000).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 187.3200, y: 190.6800).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 194.2200, y: 197.3000).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 199.5000, y: 185.1300).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 197.4700, y: 194.2600).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 199.5000, y: 189.9300).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 194.5500, y: 173.2800).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 199.5000, y: 180.3300).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 197.6100, y: 176.3000).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 194.5700, y: 165.1100).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 194.6800, y: 170.3900).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 194.6800, y: 167.6700).convert(scale: scale, offset: offset))
            path.closeSubpath()
            path.move(to: CGPoint(x: 181.9400, y: 131.1400).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 172.9000, y: 124.8800).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 177.1800, y: 126.3300).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 172.9000, y: 124.8800).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 166.0200, y: 141.0000).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 171.0100, y: 145.8600).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 167.9300, y: 142.6200).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 169.5800, y: 144.2500).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 181.9300, y: 131.1400).convert(scale: scale, offset: offset))
            path.closeSubpath()
            path.move(to: CGPoint(x: 178.5300, y: 158.2100).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 179.7400, y: 162.6800).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 179.1000, y: 159.8100).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 179.4900, y: 161.3200).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 194.4100, y: 162.3200).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 192.3200, y: 149.9600).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 194.0500, y: 157.6600).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 193.3100, y: 153.5600).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 178.5300, y: 158.2100).convert(scale: scale, offset: offset))
            path.closeSubpath()
            path.move(to: CGPoint(x: 190.8700, y: 145.4900).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 185.4600, y: 135.2900).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 189.3200, y: 141.3500).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 187.4300, y: 137.9900).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 173.8100, y: 149.3200).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 177.4000, y: 155.4300).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 175.3300, y: 151.4300).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 176.5000, y: 153.4800).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 190.8800, y: 145.5000).convert(scale: scale, offset: offset))
            path.closeSubpath()
            path.move(to: CGPoint(x: 5.4300, y: 164.6200).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 19.8900, y: 164.8500).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 19.8200, y: 168.1800).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 19.7700, y: 166.2000).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 19.7700, y: 167.3300).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 33.8700, y: 184.6500).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 27.7800, y: 169.4400).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 33.8700, y: 176.3400).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 33.6800, y: 187.1600).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 33.8700, y: 185.5000).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 33.8100, y: 186.3400).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 23.8800, y: 187.1600).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 24.3300, y: 184.6500).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 24.1700, y: 186.3800).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 24.3300, y: 185.5300).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 17.1800, y: 177.5000).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 24.3300, y: 180.7000).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 21.1300, y: 177.5000).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 10.0300, y: 184.6500).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 13.2300, y: 177.5000).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 10.0300, y: 180.7000).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 12.6800, y: 190.2000).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 10.0300, y: 186.8900).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 11.0600, y: 188.8900).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 12.6800, y: 190.2000).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 5.7800, y: 196.8200).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 12.6800, y: 190.2000).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 5.7800, y: 196.8200).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 0.5000, y: 184.6500).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 2.5300, y: 193.7800).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 0.5000, y: 189.4500).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 5.4500, y: 172.8000).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 0.5000, y: 179.8500).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 2.3900, y: 175.8200).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 5.4300, y: 164.6300).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 5.3200, y: 169.9100).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 5.3200, y: 167.1900).convert(scale: scale, offset: offset))
            path.closeSubpath()
            path.move(to: CGPoint(x: 18.0600, y: 130.6500).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 27.1000, y: 124.3900).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 22.8200, y: 125.8400).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 27.1000, y: 124.3900).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 33.9800, y: 140.5100).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 28.9900, y: 145.3700).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 32.0700, y: 142.1300).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 30.4200, y: 143.7600).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 18.0700, y: 130.6500).convert(scale: scale, offset: offset))
            path.closeSubpath()
            path.move(to: CGPoint(x: 21.4700, y: 157.7200).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 20.2600, y: 162.1900).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 20.9000, y: 159.3200).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 20.5100, y: 160.8300).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 5.5900, y: 161.8300).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 7.6800, y: 149.4700).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 5.9500, y: 157.1700).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 6.6900, y: 153.0700).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 21.4700, y: 157.7200).convert(scale: scale, offset: offset))
            path.closeSubpath()
            path.move(to: CGPoint(x: 9.1300, y: 145.0000).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 14.5400, y: 134.8000).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 10.6800, y: 140.8600).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 12.5700, y: 137.5000).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 26.1900, y: 148.8300).convert(scale: scale, offset: offset))
            path.addCurve(to: CGPoint(x: 22.6000, y: 154.9400).convert(scale: scale, offset: offset),
                          control1: CGPoint(x: 24.6700, y: 150.9400).convert(scale: scale, offset: offset),
                          control2: CGPoint(x: 23.5000, y: 152.9900).convert(scale: scale, offset: offset))
            path.addLine(to: CGPoint(x: 9.1200, y: 145.0100).convert(scale: scale, offset: offset))
            path.closeSubpath()
        }
    }
}
