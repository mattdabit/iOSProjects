//
//  CalculatorBrainSpec.swift
//  CalculatorTDD
//
//  Created by Matthew Dabit on 6/15/17.
//  Copyright © 2017 Matthew Dabit. All rights reserved.
//

import Quick
import Nimble
@testable import CalculatorTDD

class CalculatorBrainSpec: QuickSpec {
    override func spec() {
        describe("Calculator Brain"){
            var brain = CalculatorBrain()
            
            context("setOperand"){
                it("should add to operands list when called"){
                    brain.setOperand("√")
                    expect(brain.operands).to(contain("√"))
                }
            }
            
            context("evaluate unary operations"){
                it("should return the result of sqrt of 4"){
                    brain.setOperand("4")
                    brain.setOperand("√")

                    let result = brain.evaluate()
                    
                    expect(result).to(equal(2))
                }
                
                it("should return the result of 4 squared"){
                    brain.setOperand("4")
                    brain.setOperand("x²")
                    
                    let result = brain.evaluate()
                    
                    expect(result).to(equal(16))
                }
                
                it("should return the result of 4 minus sign"){
                    brain.setOperand("4")
                    brain.setOperand("±")
                    
                    let result = brain.evaluate()
                    
                    expect(result).to(equal(-4))
                }
            }
            
            context("evaluate constants"){
                it("should set result to value π"){
                    brain.setOperand("π")
                    
                    let result = brain.evaluate()
                    
                    expect(result).to(equal(Double.pi))
                }
            }
        }
    }
}
