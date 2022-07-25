/// Copyright (c) 2019 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SpriteKit
import AVFoundation

class GameScene: SKScene {
  private var particles: SKEmitterNode?
  
  private var crocodile: SKSpriteNode!
  private var prize: SKSpriteNode!
  
  override func didMove(to view: SKView) {
    setUpPhysics()
    setUpScenery()
    setUpPrize()
    setUpVines()
    setUpCrocodile()
    setUpAudio()
  }
  
  //MARK: - Level setup
  
  private func setUpPhysics() {
    physicsWorld.contactDelegate = self  // SKPhysicsContactDelegate
    physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)  // 重力の設定
    physicsWorld.speed = 1.0  // シュミレーションの実行速度(等倍)
  }
  
  private func setUpScenery() {
    let background = SKSpriteNode(imageNamed: ImageName.background)
    background.anchorPoint = CGPoint(x: 0, y: 0)
    background.position = CGPoint(x: 0, y: 0)
    background.zPosition = Layer.background
    background.size = CGSize(width: size.width, height: size.height)
    addChild(background)
    
    let water = SKSpriteNode(imageNamed: ImageName.water)
    water.anchorPoint = CGPoint(x: 0, y: 0)
    water.position = CGPoint(x: 0, y: 0)
    water.zPosition = Layer.foreground
    water.size = CGSize(width: size.width, height: size.height * 0.2139)
    addChild(water)
  }
  
  private func setUpPrize() {
    prize = SKSpriteNode(imageNamed: ImageName.prize)
    prize.position = CGPoint(x: size.width * 0.5, y: size.height * 0.7)
    prize.zPosition = Layer.prize
    prize.physicsBody = SKPhysicsBody(circleOfRadius: prize.size.height / 2)
    prize.physicsBody?.categoryBitMask = PhysicsCategory.prize
    prize.physicsBody?.collisionBitMask = 0
    prize.physicsBody?.density = 0.5

    addChild(prize)
  }
  
  //MARK: - Vine methods
  
  private func setUpVines() {
    // plistから3本のVine情報を読み取る
    let decoder = PropertyListDecoder()
    guard
      let dataFile = Bundle.main.url(
        forResource: GameConfiguration.vineDataFile,
        withExtension: nil),
      let data = try? Data(contentsOf: dataFile),
      let vines = try? decoder.decode([VineData].self, from: data)
    else {
      return
    }
    
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
      vine.attachToPrize(prize)
    }
  }
  
  //MARK: - Croc methods
  
  private func setUpCrocodile() {
    crocodile = SKSpriteNode(imageNamed: ImageName.crocMouthClosed)
    crocodile.position = CGPoint(x: size.width * 0.75, y: size.height * 0.312)
    crocodile.zPosition = Layer.crocodile
    crocodile.physicsBody = SKPhysicsBody(
      texture: SKTexture(imageNamed: ImageName.crocMask),  // 頭と口だけの画像を用意している
      size: crocodile.size)
    crocodile.physicsBody?.categoryBitMask = PhysicsCategory.crocodile
    crocodile.physicsBody?.collisionBitMask = 0  // 跳ね返りを防ぐだけ0とする
    crocodile.physicsBody?.contactTestBitMask = PhysicsCategory.prize  // 接触確認用
    crocodile.physicsBody?.isDynamic = false  // 重力・正徳などを無視する
    
    addChild(crocodile)
    
    animateCrocodile()
  }
  
  private func animateCrocodile() {
    let duration = Double.random(in: 2...4)
    let open = SKAction.setTexture(SKTexture(imageNamed: ImageName.crocMouthOpen))
    let wait = SKAction.wait(forDuration: duration)
    let close = SKAction.setTexture(SKTexture(imageNamed: ImageName.crocMouthClosed))
    let sequence = SKAction.sequence([wait, open, wait, close])
        
    crocodile.run(.repeatForever(sequence))
  }
  
  private func runNomNomAnimation(withDelay delay: TimeInterval) {
    
  }
  
  //MARK: - Touch handling

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    particles?.removeFromParent()
    particles = nil
  }
  
  private func showMoveParticles(touchPosition: CGPoint) {
    if particles == nil {
      particles = SKEmitterNode(fileNamed: Scene.particles)
      particles!.zPosition = 1
      particles!.targetNode = self
      addChild(particles!)
    }
    particles!.position = touchPosition
  }
  
  //MARK: - Game logic
  
  private func checkIfVineCut(withBody body: SKPhysicsBody) {
    
  }
  
  private func switchToNewGame(withTransition transition: SKTransition) {
    
  }
  
  //MARK: - Audio
  
  private func setUpAudio() {
    
  }
}

extension GameScene: SKPhysicsContactDelegate {
  override func update(_ currentTime: TimeInterval) {
    
  }
  
  func didBegin(_ contact: SKPhysicsContact) {
    
  }
}

