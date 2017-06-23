//
//  ViewControllerSpec.swift
//  CalculatorTDD
//
//  Created by Matthew Dabit on 6/15/17.
//  Copyright © 2017 Matthew Dabit. All rights reserved.
//

import Quick
import Nimble
@testable import CalculatorTDD

class ViewControllerSpec: QuickSpec {
    override func spec() {
        describe("View Controller Spec"){
            let number4 = UIButton()
            number4.setTitle("4", for: .normal)
            var viewController: ViewController!
            
            beforeEach {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                UIApplication.shared.keyWindow!.rootViewController = viewController
                
                let _ = viewController.view
            }
            
            context("Initialization"){
                
                it("should have CalculatorBrain"){
                    expect(viewController.brain).toNot(beNil())
                }
                
            }
            
            context("Display Result from evaluate"){
            
                
                
                let dotButton = UIButton()
                dotButton.setTitle(".", for: .normal)

                let sqrtButton = UIButton()
                sqrtButton.setTitle("√", for: .normal)
                
                it("should set display text to 2"){
                    viewController.touchDigit(number4)
                    viewController.performOperation(sqrtButton)
                    
                    expect(viewController.display.text!).to(equal("2"))
                }
                
                it("should set display text to 6.6332495807108, checking that floats display correctly"){
                    viewController.touchDigit(number4)
                    viewController.touchDigit(number4)
                    
                    viewController.performOperation(sqrtButton)
                    
                    expect(viewController.display.text!).to(equal("6.6332495807108"))
                }
                
                it("should set display text to 0.4"){
                    viewController.touchDot(dotButton)
                    viewController.touchDigit(number4)
                    
                    expect(viewController.display.text!).to(equal("0.4"))
                }
            }
            
            context("clear button"){
                let clear = UIButton()
                clear.setTitle("C", for: .normal)
                let plus = UIButton()
                plus.setTitle("+", for: .normal)
                let memory = UIButton()
                memory.setTitle("M", for: .normal)
                let equalButton = UIButton()
                equalButton.setTitle("=", for: .normal)
                let memorySet = UIButton()
                memorySet.setTitle("→M", for: .normal)
                
                
                it("should clear memory and text variables"){
                    viewController.touchDigit(number4)
                    viewController.performOperation(plus)
                    viewController.performOperation(memory)
                    viewController.performOperation(equalButton)
                    viewController.touchDigit(number4)
                    viewController.performWithVariables(memorySet)
                    
                    expect(viewController.displayDescription.text!).to(equal("4 + M ="))
                    expect(viewController.displayMemory.text!).to(equal("M: 4"))

                    viewController.performOperation(clear)
                    
                    expect(viewController.displayDescription.text!).to(equal(" "))
                    expect(viewController.displayMemory.text!).to(equal(" "))
                }
            }
        }
    }
}
