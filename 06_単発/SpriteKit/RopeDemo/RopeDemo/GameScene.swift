//
//  GameScene.swift
//  RopeDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/25.
//

import SpriteKit

class GameScene: SKScene {
    
    // MARK: - Properties
    
    private var prize: SKSpriteNode!
    
    // MARK: - Lifecycles
    
    // MARK: - Overrides
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.windowBackgroundColor
        
        setUpPhysics()
        setUpPrize()
        setUpVines()
    }
    
    // MARK: - Helpers
    
    private func setUpPrize() {
        prize = SKSpriteNode(imageNamed: ImageName.vineTexture)
        prize.position = CGPoint(x: size.width * 0.5, y: size.height * 0.7)
        prize.zPosition = Layer.prize

        prize.physicsBody = SKPhysicsBody(circleOfRadius: prize.size.height / 2)
        prize.physicsBody?.isDynamic = false
        prize.physicsBody?.categoryBitMask = PhysicsCategory.prize
        prize.physicsBody?.collisionBitMask = 0
//        prize.physicsBody?.density = 0.5
        
        addChild(prize)
    }
    
    private func setUpPhysics() {
        //      physicsWorld.contactDelegate = self  // SKPhysicsContactDelegate
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)  // 重力の設定
        physicsWorld.speed = 1.0  // シュミレーションの実行速度(等倍)
    }
    
    private func setUpVines() {
        
        let vineData = VineData(length: 50, relAnchorPoint: CGPoint(x: 0.25, y: 0.8))
        
        let anchorPoint = CGPoint(
            x: vineData.relAnchorPoint.x * size.width,
            y: vineData.relAnchorPoint.y * size.height)
        
        let anchorEndPoint = CGPoint(
            x: (vineData.relAnchorPoint.x + 0.5) * size.width,
            y: vineData.relAnchorPoint.y * size.height)
        
        let vine = VineNode(
            length: vineData.length,
            anchorPoint: anchorPoint,
            anchorEndPoint: anchorEndPoint,
            name: "vine1")
        
        // 2 add to scene
        vine.addToScene(self)
        
        // 3 connect the other end of the vine to the prize
        //        vine.attachToPrize(prize)
        
        guard let lastNode = vine.vineSegments.last else {
            return
        }
        lastNode.position = CGPoint(x: prize.position.x,
                                    y: prize.position.y + prize.size.height * 0.1)
        
        let joint = SKPhysicsJointPin.joint(withBodyA: lastNode.physicsBody!,
                                            bodyB: prize.physicsBody!,
                                            anchor: lastNode.position)
        scene?.physicsWorld.add(joint)
    }
    
}
