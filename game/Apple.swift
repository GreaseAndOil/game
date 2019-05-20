//
//  apple.swift
//  game
//
//  Created by Felipe Jun Iglesia on 5/9/19.
//  Copyright © 2019 Felipe Jun Iglesia. All rights reserved.
//

import Foundation
import SpriteKit

class Apple {
    var sprite = SKSpriteNode(imageNamed: "appleImage")


    init() {
        sprite.position = CGPoint(x: Int.random(in: -200...200), y: Int.random(in: -500...500))
    }
}
