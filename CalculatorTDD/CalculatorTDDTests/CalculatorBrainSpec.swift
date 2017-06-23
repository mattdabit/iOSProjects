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
                
                context("the description"){
                    it("should be 7 + ..."){
                        brain.setOperand("7")
                        brain.setOperand("+")
                        let results = brain.evaluate()

                        expect(results.description).to(equal("7 + ..."))
                    }
                    
                    it("should be 7 + 9 ="){
                        brain.setOperand("7")
                        brain.setOperand("+")
                        brain.setOperand("9")
                        brain.setOperand("=")

                        let results = brain.evaluate()
                        
                        expect(results.description).to(equal("7 + 9 ="))
                    }
                    
                    it("should be √(7 + 9) ="){
                        brain.setOperand("7")
                        brain.setOperand("+")
                        brain.setOperand("9")
                        brain.setOperand("=")
                        brain.setOperand("√")
                        
                        let results = brain.evaluate()
                        
                        expect(results.description).to(equal("√(7 + 9) ="))
                    }
                    
                    it("should be √(7 + 9) + 2 ="){
                        brain.setOperand("7")
                        brain.setOperand("+")
                        brain.setOperand("9")
                        brain.setOperand("=")
                        brain.setOperand("√")
                        brain.setOperand("+")
                        brain.setOperand("2")
                        brain.setOperand("=")

                        
                        let results = brain.evaluate()
                        
                        expect(results.description).to(equal("√(7 + 9) + 2 ="))
                    }
                    
                    it("should be 7 + √(9) ..."){
                        brain.setOperand("7")
                        brain.setOperand("+")
                        brain.setOperand("9")
                        brain.setOperand("√")
                        
                        let results = brain.evaluate()
                        
                        expect(results.description).to(equal("7 + √(9) ..."))
                    }
                    
                    it("should be 7 + √(9.5) ..."){
                        brain.setOperand("7")
                        brain.setOperand("+")
                        brain.setOperand("9.5")
                        brain.setOperand("√")
                        
                        let results = brain.evaluate()
                        
                        expect(results.description).to(equal("7 + √(9.5) ..."))
                    }
                    
                    it("should be 7 + √(9) ="){
                        brain.setOperand("7")
                        brain.setOperand("+")
                        brain.setOperand("9")
                        brain.setOperand("√")
                        brain.setOperand("=")

                        
                        let results = brain.evaluate()
                        
                        expect(results.description).to(equal("7 + √(9) ="))
                    }
                    
                    it("should be 7 + 9 + 6 + 3 ="){
                        brain.setOperand("7")
                        brain.setOperand("+")
                        brain.setOperand("9")
                        brain.setOperand("=")
                        brain.setOperand("+")
                        brain.setOperand("6")
                        brain.setOperand("=")
                        brain.setOperand("+")
                        brain.setOperand("3")
                        brain.setOperand("=")
                        
                        let results = brain.evaluate()
                        
                        expect(results.description).to(equal("7 + 9 + 6 + 3 ="))
                    }
                    
                    it("should be 6 + 3 ="){
                        brain.setOperand("7")
                        brain.setOperand("+")
                        brain.setOperand("9")
                        brain.setOperand("=")
                        brain.setOperand("√")
                        brain.setOperand("6")
                        brain.setOperand("+")
                        brain.setOperand("3")
                        brain.setOperand("=")
                        
                        let results = brain.evaluate()
                        
                        expect(results.description).to(equal("6 + 3 ="))
                    }
                    
                    it("should be 4 + π ="){
                        brain.setOperand("4")
                        brain.setOperand("+")
                        brain.setOperand("π")
                        brain.setOperand("=")
                        
                        let results = brain.evaluate()
                        
                        expect(results.description).to(equal("4 + π ="))
                    }
                }
        
                context("unary operations"){
                    it("should return the result of sqrt of 4"){
                        brain.setOperand("4")
                        brain.setOperand("√")
                        
                        let results = brain.evaluate()
                        
                        expect(results.result).to(equal(2))
                    }
                    
                    it("should return the result of 4 squared"){
                        brain.setOperand("4")
                        brain.setOperand("x²")
                        
                        let results = brain.evaluate()
                        
                        expect(results.result).to(equal(16))
                    }
                    
                    it("should return the result of 4 minus sign"){
                        brain.setOperand("4")
                        brain.setOperand("±")
                        
                        let results = brain.evaluate()
                        
                        expect(results.result).to(equal(-4))
                    }
                    
                    it("should return the result of sin(0)"){
                        brain.setOperand("0")
                        brain.setOperand("sin")
                        
                        let results = brain.evaluate()
                        
                        expect(results.result).to(equal(0))
                    }
                    
                    it("should return the result of cos(0)"){
                        brain.setOperand("0")
                        brain.setOperand("cos")
                        
                        let results = brain.evaluate()
                        
                        expect(results.result).to(equal(1))
                    }
                    
                    it("should return the result of tan(0)"){
                        brain.setOperand("0")
                        brain.setOperand("tan")
                        
                        let results = brain.evaluate()
                        
                        expect(results.result).to(equal(0))
                    }
                }
                
                context("constants"){
                    it("should return the value of π"){
                        brain.setOperand("π")
                        
                        let results = brain.evaluate()
                        
                        expect(results.result).to(equal(Double.pi))
                    }
                    
                    it("should return the value of e"){
                        brain.setOperand("e")
                        
                        let results = brain.evaluate()
                        
                        expect(results.result).to(equal(M_E))
                    }
                }
                
                context("binary operations"){
                    it("should return 2 plus 3"){
                        brain.setOperand("2")
                        brain.setOperand("+")
                        brain.setOperand("3")
                        brain.setOperand("=")

                        let results = brain.evaluate()
                        
                        expect(results.result).to(equal(5))
                    }
                    
                    it("should return the 2 times 3"){
                        brain.setOperand("2")
                        brain.setOperand("×")
                        brain.setOperand("3")
                        brain.setOperand("=")
                        
                        let results = brain.evaluate()
                        
                        expect(results.result).to(equal(6))
                    }
                    
                    it("should return the 3 minus 2"){
                        brain.setOperand("3")
                        brain.setOperand("-")
                        brain.setOperand("2")
                        brain.setOperand("=")
                        
                        let results = brain.evaluate()
                        
                        expect(results.result).to(equal(1))
                    }
                    
                    it("should return the 4 divided 2"){
                        brain.setOperand("4")
                        brain.setOperand("÷")
                        brain.setOperand("2")
                        brain.setOperand("=")
                        
                        let results = brain.evaluate()
                        
                        expect(results.result).to(equal(2))
                    }
                }
                
                context("clear"){
                    it("should return 0 as result"){
                        brain.setOperand("4")
                        brain.setOperand("÷")
                        brain.setOperand("2")
                        brain.setOperand("=")
                        brain.setOperand("C")
                        
                        let results = brain.evaluate()
                        expect(results.result).to(equal(0))
                    }
                }
            }
        }
    }
}
