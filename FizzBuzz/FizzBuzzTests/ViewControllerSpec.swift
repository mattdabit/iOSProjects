//
//  ViewControllerSpec.swift
//  FizzBuzz
//
//  Created by Matthew Dabit on 6/15/17.
//  Copyright © 2017 Matthew Dabit. All rights reserved.
//

import Quick
import Nimble
@testable import FizzBuzz

class ViewControllerSpec: QuickSpec {
    override func spec() {
        describe("ViewController"){
            context("playing game"){
                var viewController: ViewController!
                
                beforeEach {
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                    UIApplication.shared.keyWindow!.rootViewController = viewController
                    
                    let _ = viewController.view
                }
                
                it("should have game"){
                    expect(viewController.game).notTo(beNil())
                }
                
                it("should increment score by 1"){
                    viewController.play(move: "1.0")
                    let newScore = viewController.gameScore
                    expect(newScore).to(equal(1))
                }
                
                it("should increment score to 2"){
                    viewController.play(move: "1.0")
                    viewController.play(move: "2.0")

                    let newScore = viewController.gameScore
                    expect(newScore).to(equal(2))
                }
                
                it("should increment score for Fizz"){
                    viewController.game?.score = 2
                    viewController.play(move: "Fizz")
                    let newScore = viewController.gameScore
                    expect(newScore).to(equal(3))
                }
                
                it("should increment score for Buzz"){
                    viewController.game?.score = 4
                    viewController.play(move: "Buzz")
                    let newScore = viewController.gameScore
                    expect(newScore).to(equal(5))
                }
                
                it("should increment score for FizzBuzz"){
                    viewController.game?.score = 14
                    viewController.play(move: "FizzBuzz")
                    let newScore = viewController.gameScore
                    expect(newScore).to(equal(15))
                }
                
                it("should not increment score for wrong move"){
                    viewController.game?.score = 13
                    viewController.play(move: "Fizz")
                    let newScore = viewController.gameScore
                    expect(newScore).to(equal(13))
                }
            }
        }
    }
}
