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
            
            // Are there '=' and ')'?
            // If not, end the search.
            if let rightParenthesisIndex: Range<String.Index> = note.range(of: ")", range: subRange),
               let equalIndex: Range<String.Index> = note.range(of: "=", range: subRange) {
                
                let beforeRightParenthesisIndex: String.Index = note.index(before: rightParenthesisIndex.lowerBound)
                
                // If before index of ')' is index of '=', these indexes are considered '=)'.
                // So the string between 'formulaHead' and 'equalIndex' is the formula.
                if beforeRightParenthesisIndex == equalIndex.lowerBound {
                    results.append(formulaHead.upperBound..<equalIndex.lowerBound)
                }
                
                // Decide a next search range.
                // Compares 'equalIndex' and 'rightParenthesis', use the next search range from the lower index to the end index.
                if equalIndex.upperBound < rightParenthesisIndex.upperBound {
                    searchRange = equalIndex.upperBound..<note.endIndex
                } else {
                    searchRange = rightParenthesisIndex.upperBound..<note.endIndex
                }

            } else {
                // Not found end of formula.
                break
            }
        }
        
        return results
    }
}
