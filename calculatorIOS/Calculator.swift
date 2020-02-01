//
//  Calculator.swift
//  calculatorIOS
//
//  Created by Astam Kurbanov on 2/1/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import Foundation
class Calculator {
    
    //MARK: - Constants
    enum Operation {
        case equals
        case binary(function: (Double, Double) -> Double)
        case unary(function: (Double) -> Double)
        case constant(value: Double)
        case clean
    }
    
    var map: [String: Operation] = [
        "-" : .binary{ $0 - $1 },
        "+" : .binary{ $0 + $1 },
        "x" : .binary{ $0 * $1 },
        "/" : .binary{ $0 / $1 },
        "x!" : .unary{ factorial($0)},
        "%" : .unary { $0 / 100 },
        "x^y" : .binary{ pow($0, $1) },
        "Rand" : .constant( value: Double.random(in: 0.0 ..< 100000.0)),
        "Pi" : .constant(value: Double.pi),
        "Sqrt" : .unary{ sqrt($0) },
        "C" : .constant (value: 0),
        "AC" : .clean,
        "=" : .equals
    ]
        
    //MARK: - Variables
    var result:Double = 0
    var lastBinaryOperation: ((Double, Double) -> Double)?
    var reminder: Double = 0
    
    //MARK: - Methods
    func setOperands (number: Double) {
        result = number
    }
    
    func execute (symbol: String) {
        guard let operation = map[symbol] else { return }
        
        switch operation {
        case .clean:
            result = 0
            lastBinaryOperation = nil
            reminder = 0
        case .constant(let value):
            result = value
        case .unary(let function):
            result = function(result)
        case .binary( let function):
            lastBinaryOperation = function
            reminder = result
        case .equals:
            if let lastOperation = lastBinaryOperation {
                    result = lastOperation(reminder, result)
                    lastBinaryOperation = nil
                    reminder = 0
            }
        }
        
    }
    
    static func factorial(_ n: Double) -> Double {
        if n == 0 {
            return 1
        }
        else {
            return n * factorial(n - 1)
        }
    }

}
