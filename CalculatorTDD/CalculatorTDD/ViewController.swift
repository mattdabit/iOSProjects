//
//  ViewController.swift
//  CalculatorTDD
//
//  Created by Matthew Dabit on 6/15/17.
//  Copyright © 2017 Matthew Dabit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var brain = CalculatorBrain()
    
    @IBOutlet weak var display: UILabel!
    
    var userInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
            userInTheMiddleOfTyping = true
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        
        if userInTheMiddleOfTyping  {
            brain.setOperand(display.text!)
            userInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.setOperand(mathematicalSymbol)
        }
        
        let result = brain.evaluate()
        if let resultValue = result{
            if floor(resultValue) == resultValue{
                display.text = String(format: "%.0f", resultValue)
            } else {
                display.text = String(resultValue)
            }
        }
       
    }
}

