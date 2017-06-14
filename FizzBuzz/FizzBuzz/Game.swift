//
//  Game.swift
//  FizzBuzz
//
//  Created by Matthew Dabit on 6/14/17.
//  Copyright © 2017 Matthew Dabit. All rights reserved.
//

import Foundation

class Game {
    var score: Double
    let brain = Brain()
    
    init() {
        score = 0
    }
    
    func play(move playerMove: String) -> Bool{
        let result = brain.check(number: score + 1)
        
        if result == playerMove {
            score += 1
            return true
        } else {
            return false
        }
    }
}
