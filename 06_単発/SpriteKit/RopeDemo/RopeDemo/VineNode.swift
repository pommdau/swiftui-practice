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
    private let startAnchorPoint: CGPoint
    private let endAnchorPoint: CGPoint
    var startAnchor: SKShapeNode!
    var endAnchor: SKShapeNode!
    var vineSegments: [SKNode] = []
    
    init(length: Int, anchorPoint: CGPoint, anchorEndPoint: CGPoint, name: String) {
        self.length = length
        self.startAnchorPoint = anchorPoint
        self.endAnchorPoint = anchorEndPoint
        
        super.init()
        self.name = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.length = aDecoder.decodeInteger(forKey: "length")
        self.startAnchorPoint = aDecoder.decodePoint(forKey: "anchorPoint")
        self.endAnchorPoint = aDecoder.decodePoint(forKey: "anchorEndPoint")
        
        super.init(coder: aDecoder)
    }
    
    func addToScene(_ scene: SKScene) {
        // add vine to scene
        zPosition = Layer.vine
        scene.addChild(self)
        
        // create vine holder
        // つるの保持する点の作成
        
        startAnchor = Self.createAnchor()
        startAnchor.position = startAnchorPoint
        addChild(startAnchor)
        
        // add each of the vine parts
        // つるの作成
        for i in 0..<length {
            let vineSegment = SKSpriteNode(imageNamed: ImageName.vineTexture)
            let offset = vineSegment.size.height * CGFloat(i + 1)
            vineSegment.position = CGPoint(x: startAnchorPoint.x, y: startAnchorPoint.y - offset)
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
        lastNode.position = endAnchorPoint
        
        endAnchor = Self.createAnchor()
        endAnchor.position = endAnchorPoint
        addChild(endAnchor)
        
        let joint2 = SKPhysicsJointPin.joint(withBodyA: lastNode.physicsBody!,
                                            bodyB: endAnchor.physicsBody!,
                                            anchor: lastNode.position)
        scene.physicsWorld.add(joint2)
        
    }

}

extension VineNode {
    
    private static func createAnchor() -> SKShapeNode {
        let anchor = SKShapeNode(circleOfRadius: 10)
        anchor.fillColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        anchor.lineWidth = 4
        anchor.strokeColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        anchor.zPosition = 1
        anchor.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        anchor.physicsBody?.isDynamic = false
        anchor.physicsBody?.categoryBitMask = PhysicsCategory.vineHolder
        anchor.physicsBody?.collisionBitMask = 0
        
        return anchor
    }
    
}
