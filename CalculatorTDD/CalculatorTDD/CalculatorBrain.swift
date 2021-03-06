//
//  CalculatorBrain.swift
//  CalculatorTDD
//
//  Created by Matthew Dabit on 6/15/17.
//  Copyright © 2017 Matthew Dabit. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private enum Operation {
        case unaryOperation((Double) -> Double)
        case constant(Double)
        case binaryOperation((Double, Double) -> Double)
        case equal
        case clear

    }
    
    private var operations: Dictionary<String, Operation> =
        [
            "√": Operation.unaryOperation(sqrt),
            "x²": Operation.unaryOperation({$0 * $0}),
            "±": Operation.unaryOperation({-$0}),
            "sin": Operation.unaryOperation(sin),
            "cos": Operation.unaryOperation(cos),
            "tan": Operation.unaryOperation(tan),
            "π": Operation.constant(Double.pi),
            "e": Operation.constant(M_E),
            "+": Operation.binaryOperation(+),
            "-": Operation.binaryOperation(-),
            "×": Operation.binaryOperation(*),
            "÷": Operation.binaryOperation(/),
            "=": Operation.equal,
            "C": Operation.clear
        ]
    
    var operands = [String]()
    
    mutating func setOperand(_ operand: String){
        operands.append(operand)
    }
    
    mutating func undo(){
        let _ = operands.popLast()
    }
    
    func evaluate(using variables: Dictionary<String,Double>? = nil) -> (result: Double?, description: String, isPending: Bool) {
        
        var result: Double?
        var resultIsPending = false
        let description = buildDescription()
        var pendingBinaryOperation: PendingBinaryOperation?
        
        for operand in operands {
            if let operation = operations[operand]{
                switch operation {
                    
                case .unaryOperation(let function):
                   
                    if result != nil {
                        result = function(result!)
                    }
                    
                case .constant(let value):
                    result = value
                    
                case .binaryOperation(let function):
                    resultIsPending = true
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: result!)
                    result = nil

                case .equal:
                    result = pendingBinaryOperation!.perform(secondOperand: result!)
                    resultIsPending = false
                    
                case .clear:
                    result = 0
                    resultIsPending = false
                }
                
            } else if let operandValue = Double(operand) {
                result = operandValue
                
            } else if variables?[operand] == nil{
                result = 0
                
            } else {
                result = variables?[operand]
            }

        }
        
        return (result, description, resultIsPending)
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
                        description = description.replacingOccurrences(of: " ...", with: " \(operand) ...")
                    } else {
                        description += " \(operand)"
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
                    
                case .equal:
                    isPending = false
                    description = description.replacingOccurrences(of: " ...", with: " \(operand)")
                    currentBinaryOperand = nil
                case .clear:
                    description = " "
                }
            } else if isPending {
                description = description.replacingOccurrences(of: " ...", with: " \(operand) ...")
                
            } else if description.contains("=") {
                description = operand
                
            } else {
                description += "\(operand)"
            }
            
        }
        return description
    }
    
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
        
    }
}
