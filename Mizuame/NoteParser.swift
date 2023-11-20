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
    // The found formulas are append to array as 'Range<String.Index>'.
    // If the fomula is not found, return empty array([]).
    public func parse(note: String) -> [Range<String.Index>] {
        var results: [Range<String.Index>] = []
        var searchRange: Range<String.Index> = note.startIndex..<note.endIndex
        
        while let formulaHead: Range<String.Index> = note.range(of: "(", range: searchRange) {
            
            let subRange: Range<String.Index> = formulaHead.upperBound..<note.endIndex
            
            if let formulaTail: Range<String.Index> = note.range(of: "=)", range: subRange) {
                results.append(formulaHead.upperBound..<formulaTail.lowerBound)
                searchRange = formulaTail.upperBound..<note.endIndex
            } else {
                // Not found a '=)' in the sunRbage.
                break
            }
        }
        
        return results
    }

}
