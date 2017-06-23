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
    
    @IBOutlet weak var displayDescription: UILabel!
    
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
    
    @IBAction func touchDot(_ sender: UIButton) {
        let dot = sender.currentTitle!
        let textCurrentlyInDisplay = display.text!
        
        if !textCurrentlyInDisplay.contains(dot) {
            display.text = textCurrentlyInDisplay + dot
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
        
        let results = brain.evaluate(using: variables)
        if let resultValue = results.result{
            if floor(resultValue) == resultValue{
                display.text = String(format: "%.0f", resultValue)
            } else {
                display.text = String(resultValue)
            }
        }
        displayDescription.text = results.description

    }
    
    private var variables: Dictionary<String, Double>?
    
    @IBAction func performWithVariables(_ sender: UIButton) {
        variables = ["M": Double(display.text!)!]
        let results = brain.evaluate(using: variables)
        
        if let result = results.result {
            if floor(result) == result{
                display.text = String(format: "%.0f", result)
            } else {
                display.text = String(result)
            }
        }
        
        displayDescription.text = results.description
        userInTheMiddleOfTyping = false

    }
}

