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
    }
    
    private var operations: Dictionary<String, Operation> =
        [
            "√": Operation.unaryOperation(sqrt),
            "x²": Operation.unaryOperation({$0 * $0}),
            "±": Operation.unaryOperation({-$0})
        ]
    
    var operands = [String]()
    
    mutating func setOperand(_ operand: String){
        operands.append(operand)
    }
    
    func evaluate() -> Double{
        
        var result: Double?
        
        for operand in operands {
            if let operation = operations[operand]{
                switch operation {
                case .unaryOperation(let function):
                    if result != nil {
                        result = function(result!)
                    }
                }
            } else if let operandValue = Double(operand) {
                result = operandValue
            }
            
        }
        
        return result!
    }
}
