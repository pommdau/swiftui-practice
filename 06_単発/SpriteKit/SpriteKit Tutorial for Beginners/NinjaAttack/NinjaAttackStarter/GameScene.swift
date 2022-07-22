import SpriteKit

class GameScene: SKScene {
  
  // MARK: - Properties
  
  let player = SKSpriteNode(imageNamed: "player")
  
  // MARK: - Overrides
  
  override func didMove(to view: SKView) {
    backgroundColor = SKColor.white
    player.position = CGPoint(x: size.width * 0.1,
                              y: size.height * 0.5)
    addChild(player)
    
    physicsWorld.gravity = .zero  // 重力なしの設定
    physicsWorld.contactDelegate = self
    
    run(SKAction.repeatForever(
      SKAction.sequence([
        SKAction.run(addMonster),
        SKAction.wait(forDuration: 1.0)
      ])
    ))
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    // 1 - Choose one of the touches to work with
    guard let touch = touches.first else {
      return
    }
    let touchLocation = touch.location(in: self)
    
    // 2 - Set up initial location of projectile
    // projectile: 発射物
    let projectile = SKSpriteNode(imageNamed: "projectile")
    projectile.position = player.position
    projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.width/2)
    projectile.physicsBody?.isDynamic = true
    projectile.physicsBody?.categoryBitMask = PhysicsCategory.projectile
    projectile.physicsBody?.contactTestBitMask = PhysicsCategory.monster
    projectile.physicsBody?.collisionBitMask = PhysicsCategory.none
    projectile.physicsBody?.usesPreciseCollisionDetection = true  // 高速で移動する物体に設定することが大事。
    
    // 3 - Determine offset of location to projectile
    // ベクトルの作成
    let offset = touchLocation - projectile.position
    
    // 4 - Bail out if you are shooting down or backwards
    // 今回逆向きの発射は許可しない
    if offset.x < 0 { return }
    
    // 5 - OK to add now - you've double checked position
    addChild(projectile)
    
    // 6 - Get the direction of where to shoot
    // 単位ベクトルに変換？
    let direction = offset.normalized()
    
    // 7 - Make it shoot far enough to be guaranteed off screen
    // *1000すれば画面外になるだろうという割と適当な値
    let shootAmount = direction * 1000
    
    // 8 - Add the shoot amount to the current position
    let realDest = shootAmount + projectile.position
    
    // 9 - Create the actions
    let actionMove = SKAction.move(to: realDest, duration: 2.0)
    let actionMoveDone = SKAction.removeFromParent()
    projectile.run(SKAction.sequence([actionMove, actionMoveDone]))
  }

}

// MARK: - Helpers

extension GameScene {
  func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
  }
  
  func random(min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
  }
  
  func addMonster() {
    
    // Create sprite
    let monster = SKSpriteNode(imageNamed: "monster")
    monster.physicsBody = SKPhysicsBody(rectangleOf: monster.size) // 1: Sprite用の長方形を当たり判定を定義
    monster.physicsBody?.isDynamic = true // 2: 物理エンジンにモンスターの動きを制御させない
    monster.physicsBody?.categoryBitMask = PhysicsCategory.monster // 3: カテゴリマスクの設定
    monster.physicsBody?.contactTestBitMask = PhysicsCategory.projectile // 4:指定したカテゴリのオブジェクトと交差したときに通知する設定
    monster.physicsBody?.collisionBitMask = PhysicsCategory.none // 5: 当たり判定を無視する設定
    
    // Determine where to spawn the monster along the Y axis
    let actualY = random(min: monster.size.height/2, max: size.height - monster.size.height/2)
    
    // Position the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    monster.position = CGPoint(x: size.width + monster.size.width/2, y: actualY)
    
    // Add the monster to the scene
    addChild(monster)
    
    // Determine speed of the monster
    let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
    
    // Create the actions
    // duration: 移動にかかる時間
    let actionMove = SKAction.move(to: CGPoint(x: -monster.size.width/2, y: actualY),
                                   duration: TimeInterval(actualDuration))
    
    // removeFromParent: parentからnodeを削除
    let actionMoveDone = SKAction.removeFromParent()
    
    // sequence: SKActionを順番に連続して処理させる
    monster.run(SKAction.sequence([actionMove, actionMoveDone]))
  }
  
  // 敵と発射物が衝突した際にオブエジェクトを消す
  func projectileDidCollideWithMonster(projectile: SKSpriteNode,
                                       monster: SKSpriteNode) {
    print("Hit")
    projectile.removeFromParent()
    monster.removeFromParent()
  }
  
}
  
