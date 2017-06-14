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
            
            let brain = Brain()
            
            context("Brain divisibility"){

                it("should return true when number divisible by 3"){
                    let result = brain.isDivisibleByThree(3)
                    expect(result).to(beTrue())
                }
                
                it("should return false when number not divisible by 3"){
                    let result = brain.isDivisibleByThree(2)
                    expect(result).to(beFalse())
                }
                
                it("should return true when number divisible by 5"){
                    let result = brain.isDivisibleByFive(5)
                    expect(result).to(beTrue())
                }
                
                it("should return false when number not divisible by 5"){
                    let result = brain.isDivisibleByFive(4)
                    expect(result).to(beFalse())
                }
                
                it("should return true when number divisible by 15"){
                    let result = brain.isDivisibleByFifteen(15)
                    expect(result).to(beTrue())
                }
                
                it("should return false when number not divisible by 15"){
                    let result = brain.isDivisibleByFifteen(14)
                    expect(result).to(beFalse())
                }
            }
            
            context("Check function"){
                it("should return Fizz when divisible by 3"){
                    let result = brain.check(number: 3)
                    expect(result).to(equal("Fizz"))
                }
                
                it("should return Buzz when divisible by 5"){
                    let result = brain.check(number: 5)
                    expect(result).to(equal("Buzz"))
                }
                
                it("should return FizzBuzz when divisible by 15"){
                    let result = brain.check(number: 15)
                    expect(result).to(equal("FizzBuzz"))
                }
                
                it("should return number when not divisible by 15, 5, or 3"){
                    let result = brain.check(number: 13)
                    expect(result).to(equal("13.0"))
                }
            }
        }
    }
}
