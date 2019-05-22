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
    var controller : GameViewController?
    
    var apple = Apple()
    
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .right:
                if sneks.first!.direction != "left" {
                    sneks.first!.direction = "right"
                }
            case .left:
                if sneks.first!.direction != "right" {
                    sneks.first!.direction = "left"
                }
            case .up:
                if sneks.first!.direction != "down" {
                    sneks.first!.direction = "up"
                }
            case .down:
                if sneks.first!.direction != "up" {
                    sneks.first!.direction = "down"
                }
            default:
                break
            }
        }
    }
    
    override func didMove(to view: SKView) {
        self.addChild(sneks.first!.sprite)
        self.addChild(sneks[1].sprite)
        self.addChild(sneks[2].sprite)
        self.addChild(apple.sprite)
        
        for _ in 0...9 {
            for snek in sneks {
                snek.directions.append("up")
            }
        }
        sneks[1].sprite.position.y -= 50
        sneks[2].sprite.position.y -= 100
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        rightSwipe.direction = .right
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        leftSwipe.direction = .left
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.left
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
        sneks[0].directions.append(sneks[0].direction)
        for i in 0..<sneks.count {
            let snek = sneks[i]
            if i == sneks.count-1 {
                snek.move()
                continue
            }
            let nextSnek = sneks[i+1]
            nextSnek.directions.append(snek.directions[0])
            snek.move()
        }
        if abs(sneks.first!.sprite.position.x - apple.sprite.position.x) < 40 && abs(sneks.first!.sprite.position.y - apple.sprite.position.y) < 40 {
            apple.sprite.position = CGPoint(x: Int.random(in: -200...200), y: Int.random(in: -500...500))
            if sneks.count == 100 {
                controller!.gameOver()
            }
            let newSnek = Snek()
            self.addChild(newSnek.sprite)
            newSnek.directions = sneks.last!.directions
            newSnek.sprite.position = sneks.last!.sprite.position
            sneks.append(newSnek)
            print("count: " + String(sneks.count))
            if sneks.last!.directions.last == "up" {
                newSnek.sprite.position.y -= 50
            }
            if sneks.last!.directions.last == "down" {
                newSnek.sprite.position.y += 50
            }
            if sneks.last!.directions.last == "left" {
                newSnek.sprite.position.x += 50
            }
            if sneks.last!.directions.last == "right" {
                newSnek.sprite.position.x -= 50
            }
            

        }
        for snek in sneks {
        if snek.sprite.position.x < -350 {
            snek.sprite.position.x = 350
        }
        if snek.sprite.position.x > 350 {
            snek.sprite.position.x = -350
        }
        if snek.sprite.position.y > 700 {
            snek.sprite.position.y = -700
        }
        if snek.sprite.position.y < -700 {
             snek.sprite.position.y = 700
        }
        }
        // Called before each frame is rendered
    }
}
