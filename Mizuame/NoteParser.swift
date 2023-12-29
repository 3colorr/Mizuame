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

        // At first, extract a string that enclosed '(' and '=)' by regular expression.
        // And then, check if each the extracted string is a formula.
        note.matches(of: /(\(.+?\=\))/).forEach { matched in
            
            let matchedSubstring: Substring = matched.output.1

            // * How to check if the string is a formula? *
            // Basically, we consider the string between '(' and '=)' as a formula.
            // But, a results of this method might be incorrect.
            // If contains '(1+2+3 4 )(5*6=)' in the note, we would expect '(5*6=)' to match,
            // but '(1+2+3 4 )(5*6=)' matches.
            // Therefore, we need to remove '(1+2+3 4 )' from '(1+2+3 4 )(5*6=)'.
            // At first, Increment the index from beginning of matched string while counting number of '('.
            // If ')' is found, decrement number of '(', and if the number is not 0, continue counting number of '('.
            // If the number is 0, check if the character before ')' is '='.
            // If it is '=', the range between '(' and ')' is the formula.
            // If not, find the new '(' after index of ')', since the range between '(' and ')' is not the formula.
            // Then, repeat the search.
            //
            var headIndex = matchedSubstring.startIndex
            var searchIndex = matchedSubstring.startIndex
            var countParenthesis: Int = 0
            
            while searchIndex != matchedSubstring.endIndex {
                let char = matchedSubstring[searchIndex]
                
                if char == "(" {
                    countParenthesis += 1
                    
                } else if char == ")" {
                    countParenthesis -= 1
                    
                    if countParenthesis == 0 {
                        let equalIndex: String.Index = matchedSubstring.index(before: searchIndex)
                        
                        if matchedSubstring[equalIndex] == "=" {
                            // This is the formula.
                            // Therefore, we remove the index of '(' and ')' from it and add them to the reslut array.
                            let formulaHead = matchedSubstring.index(after: headIndex)
                            results.append(formulaHead..<equalIndex)
                            
                        } else {
                            // This is probably not the formula.
                            // Therefore, we remove it from search range.
                            headIndex = matchedSubstring.index(after: searchIndex)
                            while headIndex != matchedSubstring.endIndex && matchedSubstring[headIndex] != "(" {
                                headIndex = matchedSubstring.index(after: headIndex)
                            }
                            
                            // Increment the counter because '(' is found.
                            countParenthesis = 1
                            
                            // New search range
                            searchIndex = headIndex
                        }
                    }
                }
                
                searchIndex = matchedSubstring.index(after: searchIndex)
            }
        }
        
        return results
    }
}
