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
            "=": Operation.equal
        ]
    
    var operands = [String]()
    
    mutating func setOperand(_ operand: String){
        operands.append(operand)
    }
    
    func evaluate() -> Double? {
        
        var result: Double?
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
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: result!)
                    result = nil

                case .equal:
                    result = pendingBinaryOperation!.perform(secondOperand: result!)
                }
                
            } else if let operandValue = Double(operand) {
                result = operandValue
            }
        }
        
        return result
    }
    
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
        
    }
}
