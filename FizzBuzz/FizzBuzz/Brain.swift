//
//  Brain.swift
//  FizzBuzz
//
//  Created by Matthew Dabit on 6/14/17.
//  Copyright © 2017 Matthew Dabit. All rights reserved.
//

import Foundation

class Brain{
    
    func isDivisibleByThree(_ number: Double) -> Bool {
        return number.truncatingRemainder(dividingBy: 3) == 0
    }
    
    func isDivisibleByFive(_ number: Double) -> Bool {
        return number.truncatingRemainder(dividingBy: 5) == 0
    }
    
    func isDivisibleByFifteen(_ number: Double) -> Bool {
        return number.truncatingRemainder(dividingBy: 15) == 0
    }
    
    func check(number numberToCheck: Double) -> String {
        if isDivisibleByFifteen(numberToCheck){
            return "FizzBuzz"
        } else if isDivisibleByFive(numberToCheck) {
            return "Buzz"
        } else if isDivisibleByThree(numberToCheck){
            return "Fizz"
        }
        return String(numberToCheck)
    }
}
