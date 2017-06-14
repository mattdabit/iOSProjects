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
}
