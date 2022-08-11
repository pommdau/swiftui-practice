import SpriteKit

class GameOverScene: SKScene {
  init(size: CGSize, won: Bool) {
    super.init(size: size)
    
    // 1
    backgroundColor = SKColor.white
    
    // 2
    let message = won ? "You Won!" : "You Lose :["
    
    // 3
    let label = SKLabelNode(fontNamed: "Chalkduster")
    label.text = message
    label.fontSize = 40
    label.fontColor = SKColor.black
    label.position = CGPoint(x: size.width/2, y: size.height/2)
    addChild(label)
    
    // 4
    run(SKAction.sequence([
      SKAction.wait(forDuration: 3.0),  // 3s待機
      SKAction.run() { [weak self] in
        // 5
        guard let `self` = self else { return }
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        let scene = GameScene(size: size)  // ゲームシーンに戻る
        self.view?.presentScene(scene, transition:reveal)  // 新しい画面への遷移
      }
      ]))
   }
  
  // 6
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

