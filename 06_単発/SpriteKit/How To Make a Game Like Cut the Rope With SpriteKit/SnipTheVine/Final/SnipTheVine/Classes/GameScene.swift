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
  
  private static var backgroundMusicPlayer: AVAudioPlayer!
  
  private var sliceSoundAction: SKAction!
  private var splashSoundAction: SKAction!
  private var nomNomSoundAction: SKAction!
  
  private var isLevelOver = false
  private var didCutVine = false
  
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
    physicsWorld.contactDelegate = self
    physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
    physicsWorld.speed = 1.0
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
    // load vine data
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

    for (i, vineData) in vines.enumerated() {
      let anchorPoint = CGPoint(
        x: vineData.relAnchorPoint.x * size.width,
        y: vineData.relAnchorPoint.y * size.height)
      let vine = VineNode(length: vineData.length, anchorPoint: anchorPoint, name: "\(i)")

      vine.addToScene(self)

      vine.attachToPrize(prize)
    }
  }
  
  //MARK: - Croc methods
  
  private func setUpCrocodile() {
    crocodile = SKSpriteNode(imageNamed: ImageName.crocMouthClosed)
    crocodile.position = CGPoint(x: size.width * 0.75, y: size.height * 0.312)
    crocodile.zPosition = Layer.crocodile
    crocodile.physicsBody = SKPhysicsBody(
      texture: SKTexture(imageNamed: ImageName.crocMask),
      size: crocodile.size)
    crocodile.physicsBody?.categoryBitMask = PhysicsCategory.crocodile
    crocodile.physicsBody?.collisionBitMask = 0
    crocodile.physicsBody?.contactTestBitMask = PhysicsCategory.prize
    crocodile.physicsBody?.isDynamic = false
        
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
    crocodile.removeAllActions()

    let closeMouth = SKAction.setTexture(SKTexture(imageNamed: ImageName.crocMouthClosed))
    let wait = SKAction.wait(forDuration: delay)
    let openMouth = SKAction.setTexture(SKTexture(imageNamed: ImageName.crocMouthOpen))
    let sequence = SKAction.sequence([closeMouth, wait, openMouth, wait, closeMouth])

    crocodile.run(sequence)
  }
  
  //MARK: - Touch handling

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    didCutVine = false
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    for touch in touches {
      let startPoint = touch.location(in: self)
      let endPoint = touch.previousLocation(in: self)
      
      // check if vine cut
      scene?.physicsWorld.enumerateBodies(
        alongRayStart: startPoint,
        end: endPoint,
        using: { body, _, _, _ in
          self.checkIfVineCut(withBody: body)
      })
      
      // produce some nice particles
      showMoveParticles(touchPosition: startPoint)
    }
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
    if didCutVine && !GameConfiguration.canCutMultipleVinesAtOnce {
      return
    }
    
    let node = body.node!

    // if it has a name it must be a vine node
    if let name = node.name {
      // snip the vine
      node.removeFromParent()

      // fade out all nodes matching name
      enumerateChildNodes(withName: name, using: { node, _ in
        let fadeAway = SKAction.fadeOut(withDuration: 0.25)
        let removeNode = SKAction.removeFromParent()
        let sequence = SKAction.sequence([fadeAway, removeNode])
        node.run(sequence)
      })
      
      crocodile.removeAllActions()
      crocodile.texture = SKTexture(imageNamed: ImageName.crocMouthOpen)
      animateCrocodile()
      run(sliceSoundAction)
      didCutVine = true
    }
  }
  
  private func switchToNewGame(withTransition transition: SKTransition) {
    let delay = SKAction.wait(forDuration: 1)
    let sceneChange = SKAction.run {
      let scene = GameScene(size: self.size)
      self.view?.presentScene(scene, transition: transition)
    }

    run(.sequence([delay, sceneChange]))
  }
  
  //MARK: - Audio
  
  private func setUpAudio() {
    if GameScene.backgroundMusicPlayer == nil {
      let backgroundMusicURL = Bundle.main.url(
        forResource: SoundFile.backgroundMusic,
        withExtension: nil)
      
      do {
        let theme = try AVAudioPlayer(contentsOf: backgroundMusicURL!)
        GameScene.backgroundMusicPlayer = theme
      } catch {
        // couldn't load file :[
      }
      
      GameScene.backgroundMusicPlayer.numberOfLoops = -1
    }
    
    if !GameScene.backgroundMusicPlayer.isPlaying {
      GameScene.backgroundMusicPlayer.play()
    }
    
    sliceSoundAction = .playSoundFileNamed(
      SoundFile.slice,
      waitForCompletion: false)
    splashSoundAction = .playSoundFileNamed(
      SoundFile.splash,
      waitForCompletion: false)
    nomNomSoundAction = .playSoundFileNamed(
      SoundFile.nomNom,
      waitForCompletion: false)
  }
}

extension GameScene: SKPhysicsContactDelegate {
  override func update(_ currentTime: TimeInterval) {
    if isLevelOver {
      return
    }
    
    if prize.position.y <= 0 {
      isLevelOver = true
      run(splashSoundAction)
      switchToNewGame(withTransition: .fade(withDuration: 1.0))
    }
  }
  
  func didBegin(_ contact: SKPhysicsContact) {
    if isLevelOver {
      return
    }

    if (contact.bodyA.node == crocodile && contact.bodyB.node == prize)
      || (contact.bodyA.node == prize && contact.bodyB.node == crocodile) {
      
      isLevelOver = true
      
      // shrink the pineapple away
      let shrink = SKAction.scale(to: 0, duration: 0.08)
      let removeNode = SKAction.removeFromParent()
      let sequence = SKAction.sequence([shrink, removeNode])
      prize.run(sequence)
      run(nomNomSoundAction)
      runNomNomAnimation(withDelay: 0.15)
      // transition to next level
      switchToNewGame(withTransition: .doorway(withDuration: 1.0))
    }
  }
}
