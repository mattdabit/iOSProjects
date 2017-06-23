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
    
    func evaluate() -> (result: Double?, description: String, isPending: Bool) {
        
        var result: Double?
        var resultIsPending = false
        var description = ""
        var pendingBinaryOperation: PendingBinaryOperation?
        
        for operand in operands {
            if let operation = operations[operand]{
                switch operation {
                    
                case .unaryOperation(let function):
                    if result != nil {
                        result = function(result!)
                    }
                    
                    description = description.replacingOccurrences(of: " =", with: "")
                    description = "\(operand)(\(description)) ="

                case .constant(let value):
                    result = value
                    
                case .binaryOperation(let function):
                    resultIsPending = true
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: result!)
            
                    description = description.replacingOccurrences(of: " =", with: "")
                    description += " \(operand) ..."
                    result = nil

                case .equal:
                    var ellipsesReplacement: String
                    if floor(result!) == result!{
                        ellipsesReplacement = String(format: "%.0f", result!)
                        ellipsesReplacement += " \(operand)"
                    } else {
                        ellipsesReplacement = "\(result!) \(operand)"
                    }
                    
                    description = description.replacingOccurrences(of: "...", with: ellipsesReplacement)
                    result = pendingBinaryOperation!.perform(secondOperand: result!)
                    resultIsPending = false
                    
                case .clear:
                    result = 0
                    resultIsPending = false
                }
                
            } else if let operandValue = Double(operand) {
                result = operandValue
                if !resultIsPending {
                    description += String(operand)
                }
            }
        }
        
        return (result, description, resultIsPending)
    }
    
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
        
    }
}
