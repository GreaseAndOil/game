//
//  GameScene.swift
//  game
//
//  Created by Felipe Jun Iglesia on 4/11/19.
//  Copyright © 2019 Felipe Jun Iglesia. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var sneks = [Snek(), Snek(), Snek()]

    var apple = Apple()
    
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .right:
                sneks.first!.direction = "right"
            case .left:
                sneks.first!.direction = "left"
            case .up:
                sneks.first!.direction = "up"
            case .down:
                sneks.first!.direction = "down"
            default:
                break
            }
        }
    }
    
    override func didMove(to view: SKView) {
        self.addChild(sneks.first!.sprite)
        self.addChild(apple.sprite)
        for _ in 0...9 {
            for snek in sneks {
                snek.directions.append("up")
            }
        }
        sneks[1].sprite.position.y += 50
        sneks[2].sprite.position.y += 100
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        rightSwipe.direction = .right
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        leftSwipe.direction = .left
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        downSwipe.direction = .down
        downSwipe.direction = UISwipeGestureRecognizer.Direction.down
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        upSwipe.direction = .up
        
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(upSwipe)
        view.addGestureRecognizer(downSwipe)
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
        
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        for snek in sneks {
        snek.move()
        }
        if abs(sneks.first!.sprite.position.x - apple.sprite.position.x) < 40 && abs(sneks.first!.sprite.position.y - apple.sprite.position.y) < 40 {
            apple.sprite.position = CGPoint(x: Int.random(in: -200...200), y: Int.random(in: -500...500))
            let newSnek = Snek()
            self.addChild(Snek().sprite)
            sneks.append(newSnek)
        }
        if sneks.first!.sprite.position.x < -350 {
            sneks.first!.sprite.position.x = 350
        }
        if sneks.first!.sprite.position.x > 350 {
            sneks.first!.sprite.position.x = -350
        }
        if sneks.first!.sprite.position.y > 700 {
            sneks.first!.sprite.position.y = -700
        }
        if sneks.first!.sprite.position.y < -700 {
             sneks.first!.sprite.position.y = 700
        }

        // Called before each frame is rendered
    }
}
