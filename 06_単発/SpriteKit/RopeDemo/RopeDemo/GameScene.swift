//
//  GameScene.swift
//  RopeDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/25.
//

import SpriteKit

class GameScene: SKScene {
    
    // MARK: - Properties
    
    // MARK: - Lifecycles
    
    // MARK: - Overrides
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.windowBackgroundColor
        setUpPhysics()
        setUpVines()
    }
    
    // MARK: - Helpers
    
    private func setUpPhysics() {
//      physicsWorld.contactDelegate = self  // SKPhysicsContactDelegate
      physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)  // 重力の設定
      physicsWorld.speed = 1.0  // シュミレーションの実行速度(等倍)
    }
    
    
    private func setUpVines() {
        
        let vines: [VineData] = [
            VineData(length: 20, relAnchorPoint: CGPoint(x: 0.1, y: 0.1)),
            VineData(length: 20, relAnchorPoint: CGPoint(x: 0.5, y: 0.5))
        ]
        
        // 1 add vines
        for (i, vineData) in vines.enumerated() {
            let anchorPoint = CGPoint(
                x: vineData.relAnchorPoint.x * size.width,
                y: vineData.relAnchorPoint.y * size.height)
            let vine = VineNode(
                length: vineData.length,
                anchorPoint: anchorPoint,
                name: "\(i)")
            
            // 2 add to scene
            vine.addToScene(self)
            
            // 3 connect the other end of the vine to the prize
            //        vine.attachToPrize(prize)
        }
    }
    
}
