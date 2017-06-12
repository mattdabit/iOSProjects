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
        case memory
        case equals
        case clear
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
            "=": Operation.equals,
            "C": Operation.clear,
            "M": Operation.memory
    ]
    
    
    mutating func updateDescription(_ symbol: String){
        if let operation = operations[symbol]{
            switch operation {
            case .constant:
                if resultIsPending {
                    removeEllipsesFromDescription()
                    description += " " + symbol + " ..."
                    operationUsedWhileResultIsPending = true
                } else {
                    description += symbol
                }
                
            case .unaryOperation:
                if accumulator != nil {
                    if resultIsPending {
                        removeEllipsesFromDescription()
                        description += " " + symbol +  "(" + String(accumulator!) + ") ..."
                        operationUsedWhileResultIsPending = true
                    } else if description.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty{
                        description = symbol + "(" + String(accumulator!) + ") ="
                    } else {
                        removeEqualSignFromDescription()
                        description = " " + symbol + "(" + description + ") ="
                    }
                }
                
            case .binaryOperation:
                if accumulator != nil {
                    if description.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty {
                        description += String(accumulator!) + " " + symbol + " ..."
                    } else if description.contains("=") {
                        removeEqualSignFromDescription()
                        description += " " + symbol + " ..."
                    } else if resultIsPending {
                        removeEllipsesFromDescription()
                        description += " " + String(accumulator!) + " " + symbol + " ..."
                    } else {
                        description += " " + symbol
                    }
                }
            case .equals:
                if operationUsedWhileResultIsPending {
                    removeEllipsesFromDescription()
                    description += " ="
                    operationUsedWhileResultIsPending = false
                } else if !description.contains("="){
                    removeEllipsesFromDescription()
                    description += " " + String(accumulator!) + " ="
                }
            case .clear:
                description = " "
            
            case .memory:
                break
            }
        }
    }
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol]{
            switch operation {
                
            case .constant(let value):
                accumulator = value
                
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
                
            case .binaryOperation(let function):
                if accumulator != nil {
                    if resultIsPending {
                        performPendingBinaryOperation()
                    }
                    resultIsPending = true
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
            
                performPendingBinaryOperation()
            
            case .clear:
                resultIsPending = false
                accumulator = 0
                operationUsedWhileResultIsPending = false
            case .memory:
                break
            }
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil{
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
            resultIsPending = false
        }
    }
    
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    private var resultIsPending = false
    private var operationUsedWhileResultIsPending = false
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
        if description.contains("="){
            description = ""
        }
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    
    private mutating func removeEllipsesFromDescription(){
        description = description.replacingOccurrences(of: " ...", with: "")
    }
    
    private mutating func removeEqualSignFromDescription(){
        description = description.replacingOccurrences(of: " =", with: "")
    }
    
    
    //Assignment 2
    
    var operands = [String]()
    
    mutating func setOperand(variable named: String){
        operands.append(named)
    }
    
    func evaluate(using variables: Dictionary<String,Double>? = nil)
        -> (result: Double?, isPending: Bool, description: String){
            
            var isPending = false
            let description = buildDescription()
            var result: Double?
            var pendingBinaryOperation: PendingBinaryOperation?
            
            
            for operand in operands {
                if let operation = operations[operand] {
                    switch operation {
                        
                    case .constant(let value):
                        result = value
                        
                    case .unaryOperation(let function):
                        result = function(result!)
                        
                    case .binaryOperation(let function):

                        pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: result!)
                        result = nil
                        isPending = true
                        
                    case .equals:
                       
                        isPending = false
                        result = pendingBinaryOperation!.perform(with: result!)
                        
                    case .clear:
                        
                        isPending = false
                        result = 0
        
                    case .memory:
                        
                        if variables?[operand] == nil{
                            result = 0
                        } else {
                            result = variables?[operand]
                        }
                    }
                }
                    
                if let operandValue = Double(operand) {
                    result = operandValue
                }
            }
        
            return (result, isPending, description)
    }

    
    private func buildDescription() -> String {
        var description = ""
        var currentBinaryOperand :String?
        var isPending = false
        for operand in operands {
            
            if let operation = operations[operand] {
                switch operation {
    
                case .constant:
                    description = description.replacingOccurrences(of: " =", with: "")

                    if isPending {
                        description = description.replacingOccurrences(of: " ...", with: "\(operand) ...")
                    } else {
                        description += " " + operand
                    }
                case .unaryOperation:
                    if isPending {
                        description = description.replacingOccurrences(of: "\(currentBinaryOperand!) ", with: "\(currentBinaryOperand!) \(operand)(")
                        description = description.replacingOccurrences(of: " ...", with: ") ...")
                    } else {
                        description = description.replacingOccurrences(of: " =", with: "")
                        description = "\(operand)(\(description)) ="
                    }
                case .binaryOperation:
                   
                    isPending = true
                    currentBinaryOperand = operand
                    description = description.replacingOccurrences(of: " =", with: "")
                    description += " " + operand + " ..."
                case .equals:
                    isPending = false
                    description = description.replacingOccurrences(of: " ...", with: " \(operand)")
                    currentBinaryOperand = nil

                case .clear:    
                    description = " "
                case .memory:
                    
                    if isPending {
                        description = description.replacingOccurrences(of: "...", with: "M ...")
                    } else {
                        description += " M"
                    }
                }
            } else if isPending {
                description = description.replacingOccurrences(of: " ...", with: " \(operand) ...")
            } else if description.contains("=") {
                description = operand
            } else {
                description += " " + operand
            }
        }
        return description
    }
}
