//
//  ViewController.swift
//  Calculator
//
//  Created by Matthew Dabit on 6/6/17.
//  Copyright © 2017 Matthew Dabit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    @IBOutlet weak var displayDescription: UILabel!
    
    @IBOutlet weak var displayMemory: UILabel!
    
    var userIsInTheMiddleOfTyping = false

    @IBAction func touchDot(_ sender: UIButton) {
        let dot = sender.currentTitle!
        let textCurrentlyInDisplay = display.text!

        if !textCurrentlyInDisplay.contains(dot) {
            display.text = textCurrentlyInDisplay + dot
        }
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    private var variables: Dictionary<String, Double>?
    
    @IBAction func performOperation(_ sender: UIButton) {
        
        if userIsInTheMiddleOfTyping  {
            brain.setOperand(variable: String(displayValue))
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.setOperand(variable: mathematicalSymbol)
            if mathematicalSymbol == "C" {
                variables = [:]
                displayMemory.text = " "
            }
        }
        
        let results = brain.evaluate(using: variables)

        if let result = results.result {
            displayValue = result
        }
        
        displayDescription.text = results.description
    }
    
    @IBAction func performEvaluateWithVariables(_ sender: UIButton) {
        variables = ["M": displayValue]
        displayMemory.text = "M: \(displayValue)"
        let results = brain.evaluate(using: variables)
        
        if let result = results.result {
            displayValue = result
        }
        
        displayDescription.text = results.description
        userIsInTheMiddleOfTyping = false

    }

}

