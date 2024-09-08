//
//  NoteParser.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/11/16.
//

import Foundation

extension String {
    
    // ## Which strings does a 'getFormulas' consider to be a formula?
    // The 'getFormulas' consider the string between '(' and '=)' as a formula.
    // A ')' is must be placed after the '=', and nothing can be placed between '=' and ')'.
    // The found formulas are append to array as 'Range<String.Index>'.
    // If the fomula is not found, return empty array([]).
    func getFormulas() -> [Range<String.Index>] {
        var results: [Range<String.Index>] = []

        // At first, extract a string that enclosed '(' and '=)' by regular expression.
        // And then, check if each the extracted string is a formula.
        self.matches(of: /(\(.+?\=\))/).forEach { matched in
            
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

    // Parse the Markdown and format the string.
    //
    // We can parse the following Markdown syntax.
    //
    // # Title 1
    // ## Title 2
    // ### Title 3
    // #### Title 4
    // ##### Title 5
    // ###### Title 6
    // - List 1
    //   - List 2
    //     - List 3
    // `Code block` -> Please check this function: findRangeOfCode()
    //
    // The following Markdown syntax is parsed by Text(:AttributedString).
    //
    // **Bold**
    // *Italic*, _Italic_
    // [Link](URL)
    //
    func toMarkdown(size fontSize: Int) -> AttributedString {
        do {
            let splitedLines: [SubSequence] = self.split(separator: "\n")

            var attributedMarkdown = AttributedString()

            for line in splitedLines {
                if let prefixIndex = line.firstIndex(of: " ") {

                    var prefixEndIndex = prefixIndex

                    if prefixIndex == line.startIndex {
                        if let listPrefixIndex = line.firstIndex(of: "-") {
                            if listPrefixIndex != line.index(before: line.endIndex) {
                                prefixEndIndex = line.index(after: listPrefixIndex)
                            }
                        }
                    }

                    switch line[line.startIndex...prefixEndIndex] {
                    case "# ":
                        attributedMarkdown.append(attributed(
                            headline: line[prefixEndIndex..<line.endIndex],
                            size: 24))

                    case "## ":
                        attributedMarkdown.append(attributed(
                            headline: line[prefixEndIndex..<line.endIndex],
                            size: 18))

                    case "### ":
                        attributedMarkdown.append(attributed(
                            headline: line[prefixEndIndex..<line.endIndex],
                            size: 14))

                    case "#### ":
                        attributedMarkdown.append(attributed(
                            headline: line[prefixEndIndex..<line.endIndex],
                            size: 12))

                    case "##### ":
                        attributedMarkdown.append(attributed(
                            headline: line[prefixEndIndex..<line.endIndex],
                            size: 10))

                    case "###### ":
                        attributedMarkdown.append(attributed(
                            headline: line[prefixEndIndex..<line.endIndex],
                            size: 8))

                    case "- ":
                        attributedMarkdown.append(attributed(
                                listItem: line[prefixEndIndex..<line.endIndex],
                                size: CGFloat(fontSize),
                                dot: " \u{00B7} "))

                    case "  - ":
                        attributedMarkdown.append(attributed(
                                listItem: line[prefixEndIndex..<line.endIndex],
                                size: CGFloat(fontSize),
                                dot: "     \u{00B7} "))

                    case "    - ":
                        attributedMarkdown.append(attributed(
                                listItem: line[prefixEndIndex..<line.endIndex],
                                size: CGFloat(fontSize),
                                dot: "         \u{00B7} "))

                    default:
                        let others = try AttributedString(markdown: String(line))
                        attributedMarkdown.append(others)
                        attributedMarkdown.append(AttributedString("\n"))
                    }

                } else {
                    let others = try AttributedString(markdown: String(line))
                    attributedMarkdown.append(others)
                    attributedMarkdown.append(AttributedString("\n"))
                    print("No matched space.")
                }
            }

            return attributedMarkdown

        } catch {
            return "Could not parse the string."
        }
    }

    private func attributed(headline: Substring, size fontSize: CGFloat) -> AttributedString {
        var attr = AttributedString("\(headline)\n")
        attr.font = .system(size: fontSize, weight: .bold)

        return attr
    }

    private func attributed(listItem: Substring, size fontSize: CGFloat, dot: String) -> AttributedString {
        let attributedListItem = AttributedString("\(listItem)\n")

        var attributedDot = AttributedString(dot)
        attributedDot.font = .system(size: fontSize, weight: .heavy)
        attributedDot.append(attributedListItem)

        return attributedDot
    }

    // This function pase `code block`.
    func findRangeOfCode() -> [Range<String.Index>] {

        var results: [Range<String.Index>] = []
        var codeStartIndex = self.startIndex

        while let findIndex = self[codeStartIndex..<self.endIndex].firstIndex(of: "`") {

            codeStartIndex = self.index(after: findIndex)

            if let codeEndIndex = self[codeStartIndex..<self.endIndex].firstIndex(of: "`") {
                results.append(codeStartIndex..<codeEndIndex)
                codeStartIndex = self.index(after: codeEndIndex)

            } else {
                break
            }
        }

        return results
    }

    // ## Which strings does a 'findRangeOfFormula' consider to be a formula?
    // The 'findRangeOfFormula' assumes that a string enclosed in '(' and ')' is a formula.
    // It then searches for the assumed string and checks whether '=' and the caluculation result
    // (the calculation result is surrounded by spaces, e.g., ' 3 ') are in the specified position.
    // The found formulas are append to array 'calculations'.
    // If the fomula is not found, return empty array([]).
    func findRangeOfFormula() -> [(formula: Range<String.Index>, calculateResult: Range<String.Index>)] {

        var calculations: [(formula: Range<String.Index>, calculateResult: Range<String.Index>)] = []

        // * How to check if the string is a formula? *
        //
        // Basically, we assumes that a string enclosed in '(' and ')' is a formula.
        // But, a results of this method might be incorrect.
        //
        // If contains '(1+2+3 4 )(5*6= 30 )' in the note, we would expect '(5*6= 30 )' to match,
        // but '(1+2+3 4 )(5*6= 30 )' matches.
        //
        // [Translated by ChatGPT]
        // 1, Obtain the index of the first occurrence of '(' from the start of the string and increment 'countParenthesis'.
        //    If no match is found, terminate the search.
        // 2, Start searching from the index found in step 1. If '(' is found, increment 'countParenthesis';
        //    if ')' is found, decrement 'countParenthesis'.
        // 3, If 'countParenthesis' reaches zero during the search, retrieve the character just before the ')'.
        // 4, If the character retrieved in step 3 is a space (' '), decrement the index of the character retrieved in step 3
        //    until another space is found. If the search reaches the index found in step 1, terminate the search.
        // 5, If another space is found in step 4, retrieve the character just before that space.
        // 6, If the character retrieved in step 5 is '=', the section between the index found in step 1
        //    and the index of the ')' found in step 3 is considered a mathematical expression.
        // 7, Repeat steps 1 through 6, using the index of the ')' found in step 3 as the new starting point.
        //
        var headIndex = self.startIndex
        var searchIndex = self.startIndex
        var countParenthesis: Int = 0

        // There is no formula in a string that dose not contain any "(".
        if let findIndex = self.firstIndex(of: "(") {
            headIndex = findIndex
            searchIndex = findIndex
        } else {
            return []
        }

        while searchIndex != self.endIndex {
            let char = self[searchIndex]

            if char == "(" {
                countParenthesis += 1

            } else if char == ")" {
                countParenthesis -= 1

                if countParenthesis == 0 {
                    let blankAfterResultIndex: String.Index = self.index(before: searchIndex)

                    if self[blankAfterResultIndex] == " " {

                        var blankBeforeResultIndex = self.index(before: blankAfterResultIndex)

                        while blankBeforeResultIndex != headIndex {
                            if self[blankBeforeResultIndex] == " " {

                                let equalIndex = self.index(before: blankBeforeResultIndex)
                                if self[equalIndex] == "=" {
                                    // This is probably the formula.
                                    // Therefore, we remove the index of '(' and ')' from it and add them to the reslut array.
                                    let formulaHead = self.index(after: headIndex)
                                    calculations.append((formula: formulaHead..<blankBeforeResultIndex, calculateResult: blankBeforeResultIndex..<searchIndex))

                                    break
                                }
                            }

                            blankBeforeResultIndex = self.index(before: blankBeforeResultIndex)
                        }
                    }

                    if let findIndex = self[searchIndex..<self.endIndex].firstIndex(of: "(") {
                        headIndex = findIndex

                        // Increment the counter because '(' is found.
                        countParenthesis = 1

                        // New search range
                        searchIndex = headIndex
                    } else {
                        // The formula was not found.
                        break
                    }
                }
            }

            searchIndex = self.index(after: searchIndex)
        }

        return calculations
    }
}
