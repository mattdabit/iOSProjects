//
//  CaclulatorBrain.swift
//  Calculator
//
//  Created by Matthew Dabit on 6/7/17.
//  Copyright © 2017 Matthew Dabit. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var accumulator: Double?
    
    var description = ""
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String, Operation> =
        [
            "π": Operation.constant(Double.pi),
            "e": Operation.constant(M_E),
            "√": Operation.unaryOperation(sqrt),
            "cos": Operation.unaryOperation(cos),
            "sin": Operation.unaryOperation(sin),
            "tan": Operation.unaryOperation(tan),
            "±": Operation.unaryOperation({ -$0 }),
            "×": Operation.binaryOperation({ $0 * $1 }),
            "÷": Operation.binaryOperation({ $0 / $1 }),
            "+": Operation.binaryOperation({ $0 + $1 }),
            "-": Operation.binaryOperation({ $0 - $1 }),
            "%": Operation.binaryOperation({ $0.truncatingRemainder(dividingBy: $1) }),
            "=": Operation.equals
    ]
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol]{
            switch operation {
                
            case .constant(let value):
                
                description += symbol
                accumulator = value
                
            case .unaryOperation(let function):
                if accumulator != nil {
                    if resultIsPending {
                        description = description.replacingOccurrences(of: "...", with: "")
                        
                        description += symbol +  "(" + String(accumulator!) + ") ..."
                    } else if description.isEmpty{
                        description = symbol + "(" + String(accumulator!) + ")"
                    } else {
                        description = description.replacingOccurrences(of: "=", with: "")
                        description = " " + symbol + "(" + description + ") ="
                    }
                    
                    
                    accumulator = function(accumulator!)
                    
                }
                
            case .binaryOperation(let function):
                if accumulator != nil {
                    
                    if description.isEmpty {
                        description += String(accumulator!) + " " + symbol + " ..."
                    } else {
                        if description.contains("=") {
                            description = description.replacingOccurrences(of: "=", with: "")
                            description += " " + symbol + " ... ="

                        } else {
                            description += " " + symbol
                        }
                    
                    }

                    resultIsPending = true
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
            
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil{
            
            if description.contains("=") && resultIsPending {
                description = description.replacingOccurrences(of: "...", with: "")
                description = description.replacingOccurrences(of: "=", with: "")
                
                description += String(accumulator!) + " ="
                
            } else {
                description = description.replacingOccurrences(of: "...", with: "")
                
                description += String(accumulator!) + " ="
            }
            
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
            resultIsPending = false
        }
    }
    
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private var resultIsPending = false
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
}
