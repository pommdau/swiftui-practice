//
//  MotionManager.swift
//  ParallaxCards
//
//  Created by HIROKI IKEUCHI on 2022/07/18.
//

import CoreGraphics
import CoreMotion

class MotionMangar: ObservableObject {
    
    // MARK: - Motion Manager Properties
    
    @Published var manager: CMMotionManager = .init()
    @Published var xValue: CGFloat = 0
    
    // MARK: - Current Slide
    
    @Published var currentSlide: Place = sample_places.first!
    
    func detectMotion() {
        if !manager.isDeviceMotionActive {
            
            // MARK: For Memory Usage
            // I'm Limiting it to 40 FPS Per sec
            // You Can Update for that Your wish
            // But Please Conisder Memory Usage Too
            manager.deviceMotionUpdateInterval = 1/40
            
            manager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
                if let attitude = motion?.attitude {
                    // MARK: - Obtaining device roll value
                    self?.xValue = attitude.roll
                    print(attitude.roll)
                }
            }
        }
    }
    
    // MARK: - Stopping updates when it's not necessary
    
    func stopMotionUpdates() {
        manager.stopDeviceMotionUpdates()
    }
}

