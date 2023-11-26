//
//  NoteParser.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/11/16.
//

import Foundation

class NoteParser {
    
    // ## Which strings does a 'parse(note:)' consider to be a formula?
    // The 'parse(note:)' consider the string between '(' and '=)' as a formula.
    // A ')' is must be placed after the '=', and nothing can be placed between '=' and ')'.
    // The found formulas are append to array as 'Range<String.Index>'.
    // If the fomula is not found, return empty array([]).
    public func parse(note: String) -> [Range<String.Index>] {
        var results: [Range<String.Index>] = []
        var searchRange: Range<String.Index> = note.startIndex..<note.endIndex
        
        while let formulaHead: Range<String.Index> = note.range(of: "(", range: searchRange) {
            
            let subRange: Range<String.Index> = formulaHead.upperBound..<note.endIndex
            
            if let formulaTail: Range<String.Index> = note.range(of: "=", range: subRange) {
                
                // If the next character is ")", it adds the range from "(" to "=" into the results array.
                if formulaTail.upperBound != note.endIndex && note[formulaTail.upperBound] == ")" {
                    results.append(formulaHead.upperBound..<formulaTail.lowerBound)
                }
                
                // If not, it searches for the next formula from the next character of "=".
                searchRange = formulaTail.upperBound..<note.endIndex
            }
        }
        
        return results
    }
}
