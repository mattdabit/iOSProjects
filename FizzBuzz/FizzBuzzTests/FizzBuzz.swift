//
//  FizzBuzz.swift
//  FizzBuzz
//
//  Created by Matthew Dabit on 6/14/17.
//  Copyright © 2017 Matthew Dabit. All rights reserved.
//

import Quick
import Nimble
@testable import FizzBuzz


class FizzBuzz: QuickSpec {
    override func spec() {
        describe("FizzBuzz"){
            context("Brain"){
                it("should return true when number divisible by 3"){
                    let brain = Brain()
                    let result = brain.isDivisibleByThree(3)
                    expect(result).to(beTrue())
                }
                
                it("should return false when number not divisible by 3"){
                    let brain = Brain()
                    let result = brain.isDivisibleByThree(2)
                    expect(result).to(beFalse())
                }
                
                it("should return true when number divisible by 5"){
                    let brain = Brain()
                    let result = brain.isDivisibleByFive(5)
                    expect(result).to(beTrue())
                }
                
                it("should return false when number not divisible by 5"){
                    let brain = Brain()
                    let result = brain.isDivisibleByFive(4)
                    expect(result).to(beFalse())
                }
            }
        }
    }
}
