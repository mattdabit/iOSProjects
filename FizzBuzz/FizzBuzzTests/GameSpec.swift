//
//  Game.swift
//  FizzBuzz
//
//  Created by Matthew Dabit on 6/14/17.
//  Copyright © 2017 Matthew Dabit. All rights reserved.
//

import Quick
import Nimble
@testable import FizzBuzz

class GameSpec: QuickSpec {
    override func spec() {
        describe("Game"){
            
            let game = Game()
            
            context("Score"){
                it("should start at 0"){
                    expect(game.score).to(equal(0))
                }
                
                it("should increment by 1 when move right"){
                    game.score = 0
                    let response = game.play(move: "1.0")
                    let score = response.score

                    expect(score).to(equal(1))
                }
                
                it("should not increment when move wrong"){
                    game.score = 1
                    let response = game.play(move: "IDC")
                    let score = response.score
                    expect(score).to(equal(1))
                }
            }
            
            context("Moves"){
                it("should return true when Fizz right move"){
                    game.score = 2
                    let response = game.play(move: "Fizz")
                    let result = response.right

                    expect(result).to(beTrue())
                }
                
                it("should return false when Fizz was wrong move"){
                    game.score = 1
                    let response = game.play(move: "Fizz")
                    let result = response.right

                    expect(result).to(beFalse())
                }
                
                it("should return true when Buzz was right move"){
                    game.score = 4
                    let response = game.play(move: "Buzz")
                    let result = response.right

                    expect(result).to(beTrue())
                }
                
                it("should return false when Buzz was wrong move"){
                    game.score = 3
                    let response = game.play(move: "Buzz")
                    let result = response.right

                    expect(result).to(beFalse())
                }
                
                it("should return true when FizzBuzz was right move"){
                    game.score = 14
                    let response = game.play(move: "FizzBuzz")
                    let result = response.right

                    expect(result).to(beTrue())
                }
                
                it("should return false when FizzBuzz was wrong move"){
                    game.score = 3
                    let response = game.play(move: "FizzBuzz")
                    let result = response.right
                    
                    expect(result).to(beFalse())
                }
                
                it("should return true when number was right move"){
                    game.score = 0
                    let response = game.play(move: "1.0")
                    let result = response.right
                    
                    expect(result).to(beTrue())
                }
                
                it("should return false when number was wrong move"){
                    game.score = 2
                    let response = game.play(move: "1.0")
                    let result = response.right

                    expect(result).to(beFalse())
                }
            }
        }
    }
}
