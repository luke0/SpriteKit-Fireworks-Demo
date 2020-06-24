//
//  GameScene.swift
//  Project 20
//
//  Created by Luke Inger on 24/06/2020.
//  Copyright © 2020 Luke Inger. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    var labelScore: SKLabelNode!
    var gameTimer: Timer?
    var fireworks = [SKNode]()
    var leftEdge = -22
    var bottomEdge = -22
    var rightEdge = 1024+22
    var score = 0 {
        didSet {
            labelScore.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(launchFireworks), userInfo: nil, repeats: true)
        
    }
    
    func createFirework(xMovement:CGFloat, x: Int, y: Int){
        
        let node = SKNode()
        node.position = CGPoint(x: x, y: y)
        
        let firework = SKSpriteNode(imageNamed: "rocket")
        firework.colorBlendFactor = 1
        firework.name = "firework"
        node.addChild(firework)
        
        switch Int.random(in: 0...2) {
        case 0:
            firework.color = .cyan
            break
        case 1:
            firework.color = .green
            break
        default:
            firework.color = .red
            break
        }
        
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: xMovement, y: 2000))
        
        let move = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 200)
        node.run(move)
        
        let emitter = SKEmitterNode(fileNamed: "fuse")!
        emitter.position = CGPoint(x: 0, y: -22)
        node.addChild(emitter)
        
        fireworks.append(firework)
        addChild(node)
    }
    
    @objc func launchFireworks(){
        
        let movementAmount: CGFloat = 1800
        
        switch Int.random(in: 0...3) {
        case 0:
            //Fire up
            createFirework(xMovement: 0, x: 512, y: bottomEdge)
            createFirework(xMovement: 0, x: 512-200, y: bottomEdge)
            createFirework(xMovement: 0, x: 512-100, y: bottomEdge)
            createFirework(xMovement: 0, x: 512+100, y: bottomEdge)
            createFirework(xMovement: 0, x: 512+200, y: bottomEdge)
        case 1:
            //Fire in a fan
            createFirework(xMovement: 0, x: 512, y: bottomEdge)
            createFirework(xMovement: -200, x: 512-200, y: bottomEdge)
            createFirework(xMovement: -100  , x: 512-100, y: bottomEdge)
            createFirework(xMovement: 100, x: 512+100, y: bottomEdge)
            createFirework(xMovement: 200, x: 512+200, y: bottomEdge)
        case 2:
            //Left to right
            createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 400)
            createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 300)
            createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 200)
            createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 100)
            createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge)
        default:
            //Right to left
            createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 400)
            createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 300)
            createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 200)
            createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 100)
            createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge)
        }
        
    }
    
    

}
