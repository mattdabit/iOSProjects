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
            
            context("Display Result"){
                it("should set display text to 2 after operation"){
                    let number4 = UIButton()
                    number4.setTitle("4", for: .normal)
                    let sqrtButton = UIButton()
                    sqrtButton.setTitle("√", for: .normal)
                    
                    viewController.touchDigit(number4)
                    viewController.performOperation(sqrtButton)
                    
                    expect(viewController.display.text!).to(equal("2"))
                }
            }
        }
    }
}
