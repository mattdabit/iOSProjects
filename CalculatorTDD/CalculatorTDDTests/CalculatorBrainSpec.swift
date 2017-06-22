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
            
            describe("evaluate"){
                
                beforeEach {
                    brain.operands = []
                }
        
                context("unary operations"){
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
                
                context("constants"){
                    it("should return the value of π"){
                        brain.setOperand("π")
                        
                        let result = brain.evaluate()
                        
                        expect(result).to(equal(Double.pi))
                    }
                    
                    it("should return the value of e"){
                        brain.setOperand("e")
                        
                        let result = brain.evaluate()
                        
                        expect(result).to(equal(M_E))
                    }
                }
                
                context("binary operations"){
                    it("should return 2 plus 3"){
                        brain.setOperand("2")
                        brain.setOperand("+")
                        brain.setOperand("3")
                        brain.setOperand("=")

                        let result = brain.evaluate()
                        
                        expect(result).to(equal(5))
                    }
                    
                    it("should return the 2 times 3"){
                        brain.setOperand("2")
                        brain.setOperand("×")
                        brain.setOperand("3")
                        brain.setOperand("=")
                        
                        let result = brain.evaluate()
                        
                        expect(result).to(equal(6))
                    }
                    
                    it("should return the 3 minus 2"){
                        brain.setOperand("3")
                        brain.setOperand("-")
                        brain.setOperand("2")
                        brain.setOperand("=")
                        
                        let result = brain.evaluate()
                        
                        expect(result).to(equal(1))
                    }
                    
                    it("should return the 4 divided 2"){
                        brain.setOperand("4")
                        brain.setOperand("÷")
                        brain.setOperand("2")
                        brain.setOperand("=")
                        
                        let result = brain.evaluate()
                        
                        expect(result).to(equal(2))
                    }
                }
            }
        }
    }
}
