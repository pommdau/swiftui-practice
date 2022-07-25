//
//  VineNode.swift
//  RopeDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/25.
//

import Cocoa
import SpriteKit

class VineNode: SKNode {
    
    private let length: Int
    private let anchorPoint: CGPoint
    private let anchorEndPoint: CGPoint
    var startAnchor: SKShapeNode!
    var endAnchor: SKShapeNode!
    var vineSegments: [SKNode] = []
    
    init(length: Int, anchorPoint: CGPoint, anchorEndPoint: CGPoint, name: String) {
        self.length = length
        self.anchorPoint = anchorPoint
        self.anchorEndPoint = anchorEndPoint
        
        super.init()
        self.name = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.length = aDecoder.decodeInteger(forKey: "length")
        self.anchorPoint = aDecoder.decodePoint(forKey: "anchorPoint")
        self.anchorEndPoint = aDecoder.decodePoint(forKey: "anchorEndPoint")
        
        super.init(coder: aDecoder)
    }
    
    func addToScene(_ scene: SKScene) {
        // add vine to scene
        zPosition = Layer.vine
        scene.addChild(self)
        
        // create vine holder
        // つるの保持する点の作成
        startAnchor = SKShapeNode(circleOfRadius: 10)
        startAnchor.fillColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        startAnchor.lineWidth = 4
        startAnchor.strokeColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        startAnchor.position = anchorPoint
        startAnchor.zPosition = 1
        
        addChild(startAnchor)
        
        startAnchor.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        startAnchor.physicsBody?.isDynamic = false
        startAnchor.physicsBody?.categoryBitMask = PhysicsCategory.vineHolder
        startAnchor.physicsBody?.collisionBitMask = 0
        
        
        // add each of the vine parts
        // つるの作成
        for i in 0..<length {
            let vineSegment = SKSpriteNode(imageNamed: ImageName.vineTexture)
            let offset = vineSegment.size.height * CGFloat(i + 1)
            vineSegment.position = CGPoint(x: anchorPoint.x, y: anchorPoint.y - offset)
            vineSegment.name = name
            
            vineSegments.append(vineSegment)
            addChild(vineSegment)
            
            vineSegment.physicsBody = SKPhysicsBody(rectangleOf: vineSegment.size)
            vineSegment.physicsBody?.categoryBitMask = PhysicsCategory.vine
            vineSegment.physicsBody?.collisionBitMask = PhysicsCategory.vineHolder
        }
        
        // set up joint for vine holder
        // つるの関節を作成する
        
        // 最初の1点は特別に処理する
        let joint = SKPhysicsJointPin.joint(
            withBodyA: startAnchor.physicsBody!,
            bodyB: vineSegments[0].physicsBody!,
            anchor: CGPoint(
                x: startAnchor.frame.midX,
                y: startAnchor.frame.midY))
        
        scene.physicsWorld.add(joint)
        
        // set up joints between vine parts
        // その他の点の処理
        for i in 1..<length {
            let nodeA = vineSegments[i - 1]
            let nodeB = vineSegments[i]
            let joint = SKPhysicsJointPin.joint(
                withBodyA: nodeA.physicsBody!,
                bodyB: nodeB.physicsBody!,
                anchor: CGPoint(
                    x: nodeA.frame.midX,
                    y: nodeA.frame.minY))
            
            scene.physicsWorld.add(joint)
        }
        
        
        // 最後の点の処理
        // 3 connect the other end of the vine to the prize
        //        vine.attachToPrize(prize)
        
        guard let lastNode = vineSegments.last else {
            return
        }
        lastNode.position = anchorEndPoint
        
        let prize = SKShapeNode(circleOfRadius: 10)
        prize.fillColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        prize.lineWidth = 4
        prize.strokeColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        prize.position = anchorEndPoint
        prize.zPosition = 1
        
        addChild(prize)
        
        prize.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        prize.physicsBody?.isDynamic = false
        prize.physicsBody?.categoryBitMask = PhysicsCategory.vineHolder
        prize.physicsBody?.collisionBitMask = 0
        
        let joint2 = SKPhysicsJointPin.joint(withBodyA: lastNode.physicsBody!,
                                            bodyB: prize.physicsBody!,
                                            anchor: lastNode.position)
        scene.physicsWorld.add(joint2)
        
    }
    
//    // prize: パイナップル
//    func attachToPrize(_ prize: SKSpriteNode) {
//        // align last segment of vine with prize
//        let lastNode = vineSegments.last!
//        lastNode.position = CGPoint(x: prize.position.x,
//                                    y: prize.position.y + prize.size.height * 0.1)
//
//        // set up connecting joint
//        let joint = SKPhysicsJointPin.joint(withBodyA: lastNode.physicsBody!,
//                                            bodyB: prize.physicsBody!,
//                                            anchor: lastNode.position)
//
//        prize.scene?.physicsWorld.add(joint)
//    }
}
