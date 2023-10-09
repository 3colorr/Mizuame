//
//  CalculateModel.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/10/08.
//

import Foundation

class CalculateModel {
    
    // The result function return result of calculate function.
    // If calculation failed, return nil.
    public func result(formula: String) -> Double? {
        
        let tokens = tokenize(formula: formula)
        
        let postfixNotionTokens = postfixNotaion(of: tokens)
        
        let result = calculates(it: postfixNotionTokens)
        
        return nil
    }
    
    // The tokenize function return tokens.
    // If failure, return array size zero.
    private func tokenize(formula: String) -> [String] {
        
        let splited = Array(formula).map(String.init)
        
        var token: String = ""
        var tokens: [String] = []
        
        for n in splited {
            switch n {
            case "+":
                tokens.append(token)
                tokens.append("+")
                token = ""
            case "-":
                tokens.append(token)
                tokens.append("-")
                token = ""
            case "*":
                tokens.append(token)
                tokens.append("*")
                token = ""
            case "/":
                tokens.append(token)
                tokens.append("/")
                token = ""
            case "^":
                tokens.append(token)
                tokens.append("^")
                token = ""
            case "(":
                tokens.append(token)
                tokens.append("(")
                token = ""
            case ")":
                tokens.append(token)
                tokens.append(")")
                token = ""
            case ".":
                token += n
            default:
                // Pick up character that can be convert to numeric.
                // If failure, stop tokenaizing.
                if Double(n) != nil {
                    token += n
                } else {
                    return []
                }
            }
        }
        
        return tokens
    }
    
    // The postfixNotation function return formula in postfix notation.
    // If failure, return array size zero.
    private func postfixNotaion(of tokens: [String]) -> [String] {
        
        return []
    }
    
    // The calculates function return calculate result.
    // If calculation failed, return nil.
    public func calculates(it postNotationTokens: [String]) -> Double? {
        
        return nil
    }
}
