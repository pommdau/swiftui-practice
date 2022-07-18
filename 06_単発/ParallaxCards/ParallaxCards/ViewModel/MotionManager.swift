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
    
    func detectMotion() {
        if !manager.isDeviceMotionActive {
            manager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
                if let attitude = motion?.attitude {
                    // MARK: - Obtaining device roll value
                    self?.xValue = attitude.roll
                }
            }
        }
    }
    
    // MARK: - Stopping updates when it's not necessary
    
    func stopMotionUpdates() {
        manager.stopDeviceMotionUpdates()
    }
}

