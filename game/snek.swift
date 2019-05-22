//
//  snek.swift
//  game
//
//  Created by Felipe Jun Iglesia on 4/11/19.
//  Copyright © 2019 Felipe Jun Iglesia. All rights reserved.
//

import Foundation
import SpriteKit

class Snek {
    var direction = ""
    var directions = [String]()
    var speed = 5
    var xSpeed = 0, ySpeed = 0
    var sprite = SKSpriteNode(imageNamed: "snekImage")

    init () {
    sprite.size = CGSize(width: 50, height: 50)
    }

    func move() {
        print(directions.count)
        let dir = directions[0]
        directions.removeFirst()
        switch dir {
        case "right":
            xSpeed = 5
            ySpeed = 0
        case "left":
            xSpeed = -5
            ySpeed = 0
        case "up":
            xSpeed = 0
            ySpeed = 5
        case "down":
            xSpeed = 0
            ySpeed = -5
        default:
            break
        }
        
    sprite.position = CGPoint(x: Int(sprite.position.x) + xSpeed, y: Int(sprite.position.y) + ySpeed)
    }
}
