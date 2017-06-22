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
            
            context("Display Result for function"){
                let number0 = UIButton()
                let number1 = UIButton()
                let number2 = UIButton()
                let number3 = UIButton()
                let number4 = UIButton()
                let number5 = UIButton()
                let number6 = UIButton()
                let number7 = UIButton()
                let number8 = UIButton()
                let number9 = UIButton()

                number0.setTitle("0", for: .normal)
                number1.setTitle("1", for: .normal)
                number2.setTitle("2", for: .normal)
                number3.setTitle("3", for: .normal)
                number4.setTitle("4", for: .normal)
                number5.setTitle("5", for: .normal)
                number6.setTitle("6", for: .normal)
                number7.setTitle("7", for: .normal)
                number8.setTitle("8", for: .normal)
                number9.setTitle("9", for: .normal)

                
                context("sqrt"){
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
                }
                
                context("x²"){
                    let squareButton = UIButton()
                    squareButton.setTitle("x²", for: .normal)
                    
                    it("should set display text to 100"){
                        viewController.touchDigit(number1)
                        viewController.touchDigit(number0)

                        viewController.performOperation(squareButton)
                        
                        expect(viewController.display.text!).to(equal("100"))
                    }
                }
                
                context("±"){
                    let plusMinusButton = UIButton()
                    plusMinusButton.setTitle("±", for: .normal)
                    
                    it("should set display text to -4"){
                        viewController.touchDigit(number4)
                        viewController.performOperation(plusMinusButton)
                        
                        expect(viewController.display.text!).to(equal("-4"))
                    }
                }
            }
            
        }
    }
}
