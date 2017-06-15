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
            context("Initialization"){
                var viewController: ViewController!
                
                beforeEach {
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                    UIApplication.shared.keyWindow!.rootViewController = viewController
                    
                    let _ = viewController.view
                }
                
                it("should have CalculatorBrain"){
                    expect(viewController.brain).toNot(beNil())
                }
            }
        }
    }
}
