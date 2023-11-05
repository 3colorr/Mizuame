//
//  CalculateModel.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/10/08.
//

import Foundation

class CalculateModel {
    
    private struct token {
        let value: String
        let priority: Int
        let isOperator: Bool
        let isLeftAssociativity: Bool
        
        var operation: (Decimal, Decimal) -> Decimal = {(x: Decimal, y: Decimal) -> Decimal in return 0}

        func number() -> Decimal? {
            if let n = Decimal(string: value) {
                return n
            }
            
            return nil
        }
    }
    
    // The result function return result of calculate function.
    // If calculation failed, return nil.
    public func result(formula: String) -> Decimal? {
        
        let tokens = tokenize(formula: formula)
        
        if tokens.isEmpty {
            return nil
        }
        
        let postfixNotionTokens = postfixNotaion(of: tokens)

        if postfixNotionTokens.isEmpty {
            return nil
        }

        return calculates(it: postfixNotionTokens)
    }
    
    // The tokenize function return tokens.
    // If failure, return array size zero.
    private func tokenize(formula: String) -> [token] {
        
        let splited = Array(formula).map(String.init)
        
        var num: String = ""
        var tokens: [token] = []
        
        //
        // ## How to tokenize
        //
        // A formula is examined character by character.
        // For example, In the followings loop,
        // examined a character in order of 1, +, 2, -, 1, *, 3 when the formula is "1+2-1*3".
        //
        // If a character other than number or operators is found,
        // it cannot calcurate and return "nil".
        //
        for n in splited {
            switch n {
            case "+":
                if num != "" {
                    tokens.append(token(value: num, priority: 0, isOperator: false, isLeftAssociativity: false))
                }
                tokens.append(token(value: "+", priority: 1, isOperator: true, isLeftAssociativity: true, operation: {(x: Decimal, y: Decimal) -> Decimal in return x + y}))
                num = ""
            case "-":
                if num != "" {
                    // (e.g.) 1"-"2
                    tokens.append(token(value: num, priority: 0, isOperator: false, isLeftAssociativity: false))
                    tokens.append(token(value: "-", priority: 1, isOperator: true, isLeftAssociativity: true, operation: {(x: Decimal, y: Decimal) -> Decimal in return x - y}))
                    num = ""
                } else {
                    if let m = tokens.last {
                        if m.value != ")" {
                            // (e.g.) 1*(-2/3), 1*-2
                            num = "-"
                        } else {
                            // (e.g.) (1+2)-3
                            tokens.append(token(value: "-", priority: 1, isOperator: true, isLeftAssociativity: true, operation: {(x: Decimal, y: Decimal) -> Decimal in return x - y}))
                            num = ""
                        }
                    } else {
                        // (e.g.) -1+2
                        num = "-"
                    }
                }
            case "*":
                if num != "" {
                    tokens.append(token(value: num, priority: 0, isOperator: false, isLeftAssociativity: false))
                }
                tokens.append(token(value: "*", priority: 2, isOperator: true, isLeftAssociativity: true, operation: {(x: Decimal, y: Decimal) -> Decimal in return x * y}))
                num = ""
            case "/":
                if num != "" {
                    tokens.append(token(value: num, priority: 0, isOperator: false, isLeftAssociativity: false))
                }
                tokens.append(token(value: "/", priority: 2, isOperator: true, isLeftAssociativity: true, operation: {(x: Decimal, y: Decimal) -> Decimal in return x / y}))
                num = ""
            case "^":
                if num != "" {
                    tokens.append(token(value: num, priority: 0, isOperator: false, isLeftAssociativity: false))
                }
                tokens.append(
                    token(value: "^", priority: 3, isOperator: true, isLeftAssociativity: false,
                          operation: {
                              (x: Decimal, y: Decimal) -> Decimal in
                              let yStr = NSDecimalNumber(decimal: y).stringValue
                              
                              if let pointIndex = yStr.firstIndex(of: ".") {
                                  return Decimal.nan
                                  // FIX ME!!
                                  // The following formula cannot calculate "0.01^(-3/2)".
                                  // If the power is not an integer, return Decimal.nan(not a number) for now.
                                  /*
                                   // (e.g.) 2^(1.2)(x=2, y=1.2), 2^(-3.5)(x=2, y=-3.5)
                                   let yPointDigit = yStr.distance(from: pointIndex, to: yStr.index(before: yStr.endIndex))
                                   let mm = pow(10, yPointDigit)
                                   
                                   if y > 0 {
                                   // (e.g.) 2^(1.2)(x=2, y=1.2)
                                   return pow(1 / pow(x, NSDecimalNumber(decimal: mm).intValue), NSDecimalNumber(decimal: y * mm).intValue)
                                   } else {
                                   // (e.g.) 2^(-3.5)(x=2, y=-3.5)
                                   return pow(1 / pow(1 / x, NSDecimalNumber(decimal: mm).intValue), NSDecimalNumber(decimal: -y * mm).intValue)
                                   }
                                   */
                              } else {
                                  // (e.g.) 2^2(x=2, y=2), 2^(-3)(x=2, y=-3)
                                  if y > 0 {
                                      // (e.g.) y=2
                                      return pow(x, NSDecimalNumber(decimal: y).intValue)
                                  } else {
                                      // (e.g.) y=-3
                                      return 1 / pow(x, NSDecimalNumber(decimal: -y).intValue)
                                  }
                              }
                          }))
                num = ""
            case "(":
                if num != "" {
                    tokens.append(token(value: num, priority: 0, isOperator: false, isLeftAssociativity: false))
                }
                tokens.append(token(value: "(", priority: 0, isOperator: false, isLeftAssociativity: false))
                num = ""
            case ")":
                if num != "" {
                    tokens.append(token(value: num, priority: 0, isOperator: false, isLeftAssociativity: false))
                }
                tokens.append(token(value: ")", priority: 0, isOperator: false, isLeftAssociativity: false))
                num = ""
            case ".":
                num += n
            default:
                // Pick up character that can be convert to numeric.
                // If failure, stop tokenaizing.
                if Double(n) != nil {
                    num += n
                } else {
                    return []
                }
            }
        }
        
        // If "num" is not empty, there is a number that have not been append to array.
        // (e.g.) 1+2+"3" -> the "3" have not been append.
        if num != "" {
            tokens.append(token(value: num, priority: 0, isOperator: false, isLeftAssociativity: false))
        }
        
        return tokens
    }
    
    // The postfixNotation function return formula in postfix notation.
    //   -> "Shunting yard algorithm"
    // If failure, return array size zero.
    private func postfixNotaion(of tokens: [token]) -> [token] {
        
        var outputQue: [token] = []
        var operatorStack: [token] = []
        
        for n in tokens {
            if n.value == "(" {
                operatorStack.append(n)
                
            } else if n.value == ")" {
                while let op = operatorStack.last {
                    if op.value == "(" {
                        operatorStack.removeLast()
                        break
                    }
                    
                    if let m = operatorStack.popLast() {
                        outputQue.append(m)
                    } else {
                        return []
                    }
                }
                    
            } else if n.isOperator {
                while let op = operatorStack.last {
                    if (op.isOperator && n.isLeftAssociativity && n.priority <= op.priority) || (n.priority < op.priority) {
                        if let m = operatorStack.popLast() {
                            outputQue.append(m)
                        }
                    } else {
                        break
                    }
                }
                
                operatorStack.append(n)
                
            } else if Decimal(string: n.value) != Decimal.nan {
                outputQue.append(n)
            } else {
                return []
            }
        }
        
        while let n = operatorStack.popLast() {
            if n.value == "(" || n.value == ")" {
                return []
            }
            
            outputQue.append(n)
        }
        
        return outputQue
    }
    
    // The calculates function return calculate result.
    // If calculation failed, return nil.
    private func calculates(it postNotationTokens: [token]) -> Decimal? {
        
        var operatorStack: [Decimal] = []
        
        for n in postNotationTokens {
            if n.isOperator {
                if let x1: Decimal = operatorStack.popLast(), let x2: Decimal = operatorStack.popLast() {
                    let result: Decimal = n.operation(x2, x1)
                    
                    if result == .nan {
                        return nil
                    } else {
                        operatorStack.append(result)
                    }
                } else {
                    return nil
                }
                
            } else {
                if let m = n.number() {
                    operatorStack.append(m)
                } else {
                    return nil
                }
            }
        }
        
        // The calculation is correct when the stack has only one element.
        if operatorStack.count == 1 {
            return operatorStack.last
        }
        
        return nil
    }
}
