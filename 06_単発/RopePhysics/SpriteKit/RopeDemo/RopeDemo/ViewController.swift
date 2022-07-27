//
//  ViewController.swift
//  RopeDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/25.
//

import Cocoa
import SpriteKit

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        
        // Create and configure the scene.
        let scene = GameScene(size: CGSize(width: 800, height: 600))
        scene.scaleMode = .aspectFill
        
        // Present the scene.
        skView.presentScene(scene)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

