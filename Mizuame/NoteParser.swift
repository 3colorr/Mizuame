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

    /// Parse the Markdown and format the string.
    ///
    /// We can parse the following Markdown syntax.
    ///
    /// # Title 1
    /// ## Title 2
    /// ### Title 3
    /// #### Title 4
    /// ##### Title 5
    /// ###### Title 6
    /// - List 1
    ///   - List 2
    ///     - List 3
    ///       - List 4
    /// 1. Ordered List 1
    ///   1.  Ordered List 2
    ///     1.  Ordered List 3
    ///       1.  Ordered List 4
    /// `Code block` -> Please check this function: findRangeOfCode( )
    /// (1+2= 3 ) -> Please check this function: findRangeOfFormula( )
    ///
    /// The following Markdown syntax is parsed by Text( AttributedString: ).
    ///
    /// **Bold**
    /// *Italic*, _Italic_
    /// [Link](URL)
    ///
    func toMarkdown(size fontSize: Int) -> [MarkdownModel] {

        let splitedLines: [String] = self.components(separatedBy: "\n")

        var markdown: [MarkdownModel] = []

        for line in splitedLines {
            if let prefixIndex = line.firstIndex(of: " ") {

                var prefixEndIndex = prefixIndex

                if prefixIndex == line.startIndex {
                    if let listPrefixIndex = line.firstIndex(of: "-") {
                        if listPrefixIndex != line.index(before: line.endIndex) {
                            prefixEndIndex = line.index(after: listPrefixIndex)
                        }
                    }
                    
                    // An ordered list syntax.
                    if let orderedListPrefixStartIndex = line.firstIndex(of: "1") {

                        let orderedListPrefixEndIndex = line.index(after: orderedListPrefixStartIndex)

                        if orderedListPrefixStartIndex != line.index(before: line.endIndex) && line[orderedListPrefixEndIndex] == "." {
                            prefixEndIndex = line.index(after: orderedListPrefixEndIndex)
                        }
                    }
                }

                switch line[line.startIndex...prefixEndIndex] {
                case "# ":
                    let stringLine = String(line[line.index(after: prefixEndIndex)..<line.endIndex])
                    let viewModel = createMarkdownViewFrom(line: stringLine,
                                                           codeBlockRanges: stringLine.findRangeOfCode(),
                                                           formulaRanges: stringLine.findRangeOfFormula())

                    var model = MarkdownModel(content: viewModel)
                    model.setFontSizeOfWholeLine(is: CGFloat(fontSize) * 2.0)
                    _ = model.setFirstMarkdownViewType(to: .header1)
                    markdown.append(model)

                case "## ":
                    let stringLine = String(line[line.index(after: prefixEndIndex)..<line.endIndex])
                    let viewModel = createMarkdownViewFrom(line: stringLine,
                                                           codeBlockRanges: stringLine.findRangeOfCode(),
                                                           formulaRanges: stringLine.findRangeOfFormula())

                    var model = MarkdownModel(content: viewModel)
                    model.setFontSizeOfWholeLine(is: CGFloat(fontSize) * 1.5)
                    _ = model.setFirstMarkdownViewType(to: .header2)
                    markdown.append(model)

                case "### ":
                    let stringLine = String(line[line.index(after: prefixEndIndex)..<line.endIndex])
                    let viewModel = createMarkdownViewFrom(line: stringLine,
                                                           codeBlockRanges: stringLine.findRangeOfCode(),
                                                           formulaRanges: stringLine.findRangeOfFormula())

                    var model = MarkdownModel(content: viewModel)
                    model.setFontSizeOfWholeLine(is: CGFloat(fontSize) + 2.0)
                    _ = model.setFirstMarkdownViewType(to: .header3)
                    markdown.append(model)

                case "#### ":
                    let stringLine = String(line[line.index(after: prefixEndIndex)..<line.endIndex])
                    let viewModel = createMarkdownViewFrom(line: stringLine,
                                                           codeBlockRanges: stringLine.findRangeOfCode(),
                                                           formulaRanges: stringLine.findRangeOfFormula())

                    var model = MarkdownModel(content: viewModel)
                    model.setFontSizeOfWholeLine(is: CGFloat(fontSize))
                    _ = model.setFirstMarkdownViewType(to: .header4)
                    markdown.append(model)

                case "##### ":
                    let stringLine = String(line[line.index(after: prefixEndIndex)..<line.endIndex])
                    let viewModel = createMarkdownViewFrom(line: stringLine,
                                                           codeBlockRanges: stringLine.findRangeOfCode(),
                                                           formulaRanges: stringLine.findRangeOfFormula())

                    var model = MarkdownModel(content: viewModel)
                    model.setFontSizeOfWholeLine(is: CGFloat(fontSize) - 2.0)
                    _ = model.setFirstMarkdownViewType(to: .header5)
                    markdown.append(model)

                case "###### ":
                    let stringLine = String(line[line.index(after: prefixEndIndex)..<line.endIndex])
                    let viewModel = createMarkdownViewFrom(line: stringLine,
                                                           codeBlockRanges: stringLine.findRangeOfCode(),
                                                           formulaRanges: stringLine.findRangeOfFormula())

                    var model = MarkdownModel(content: viewModel)
                    model.setFontSizeOfWholeLine(is: CGFloat(fontSize) * 0.5)
                    _ = model.setFirstMarkdownViewType(to: .header6)
                    markdown.append(model)

                case "- ":
                    let stringLine = String(line[line.index(after: prefixEndIndex)..<line.endIndex])
                    let viewModel = createMarkdownViewFrom(line: stringLine,
                                                           codeBlockRanges: stringLine.findRangeOfCode(),
                                                           formulaRanges: stringLine.findRangeOfFormula())

                    var model = MarkdownModel(content: viewModel)
                    model.setFontSizeOfWholeLine(is: CGFloat(fontSize))
                    _ = model.setFirstMarkdownViewType(to: .list1)
                    markdown.append(model)

                case "  - ":
                    let stringLine = String(line[line.index(after: prefixEndIndex)..<line.endIndex])
                    let viewModel = createMarkdownViewFrom(line: stringLine,
                                                           codeBlockRanges: stringLine.findRangeOfCode(),
                                                           formulaRanges: stringLine.findRangeOfFormula())

                    var model = MarkdownModel(content: viewModel)
                    model.setFontSizeOfWholeLine(is: CGFloat(fontSize))
                    _ = model.setFirstMarkdownViewType(to: .list2)
                    markdown.append(model)

                case "    - ":
                    let stringLine = String(line[line.index(after: prefixEndIndex)..<line.endIndex])
                    let viewModel = createMarkdownViewFrom(line: stringLine,
                                                           codeBlockRanges: stringLine.findRangeOfCode(),
                                                           formulaRanges: stringLine.findRangeOfFormula())

                    var model = MarkdownModel(content: viewModel)
                    model.setFontSizeOfWholeLine(is: CGFloat(fontSize))
                    _ = model.setFirstMarkdownViewType(to: .list3)
                    markdown.append(model)

                case "      - ":
                    let stringLine = String(line[line.index(after: prefixEndIndex)..<line.endIndex])
                    let viewModel = createMarkdownViewFrom(line: stringLine,
                                                           codeBlockRanges: stringLine.findRangeOfCode(),
                                                           formulaRanges: stringLine.findRangeOfFormula())

                    var model = MarkdownModel(content: viewModel)
                    model.setFontSizeOfWholeLine(is: CGFloat(fontSize))
                    _ = model.setFirstMarkdownViewType(to: .list4)
                    markdown.append(model)

                case "1. ":
                    let stringLine = String(line[line.index(after: prefixEndIndex)..<line.endIndex])
                    let viewModel = createMarkdownViewFrom(line: stringLine,
                                                           codeBlockRanges: stringLine.findRangeOfCode(),
                                                           formulaRanges: stringLine.findRangeOfFormula())

                    var model = MarkdownModel(content: viewModel)
                    model.setFontSizeOfWholeLine(is: CGFloat(fontSize))
                    _ = model.setFirstMarkdownViewType(to: .ordered1)

                    if markdown.count == 0 {
                        _ = model.setOrderedList(number: 0)

                    } else {
                        for elem in markdown.reversed() {
                            if elem.viewTypeOfFirstMarkdownTextView() != .ordered1 &&
                                elem.viewTypeOfFirstMarkdownTextView() != .ordered2 &&
                                elem.viewTypeOfFirstMarkdownTextView() != .ordered3 &&
                                elem.viewTypeOfFirstMarkdownTextView() != .ordered4 {

                                // Here, we expect the first line to be an ordered line.
                                _ = model.setOrderedList(number: 0)
                                break
                                
                            } else if elem.viewTypeOfFirstMarkdownTextView() == .ordered1 {
                                _ = model.setOrderedList(number: elem.orderedListNumber() + 1)
                                break
                            }
                        }
                    }

                    markdown.append(model)

                case "  1. ":
                    let stringLine = String(line[line.index(after: prefixEndIndex)..<line.endIndex])
                    let viewModel = createMarkdownViewFrom(line: stringLine,
                                                           codeBlockRanges: stringLine.findRangeOfCode(),
                                                           formulaRanges: stringLine.findRangeOfFormula())

                    var model = MarkdownModel(content: viewModel)
                    model.setFontSizeOfWholeLine(is: CGFloat(fontSize))
                    _ = model.setFirstMarkdownViewType(to: .ordered2)

                    if markdown.count == 0 {
                        _ = model.setOrderedList(number: 0)

                    } else {
                        for elem in markdown.reversed() {
                            if elem.viewTypeOfFirstMarkdownTextView() != .ordered2 &&
                                elem.viewTypeOfFirstMarkdownTextView() != .ordered3 &&
                                elem.viewTypeOfFirstMarkdownTextView() != .ordered4 {
                                
                                // Here, we expect the first line to be an ordered line.
                                _ = model.setOrderedList(number: 0)
                                break
                                
                            } else if elem.viewTypeOfFirstMarkdownTextView() == .ordered2 {
                                _ = model.setOrderedList(number: elem.orderedListNumber() + 1)
                                break
                            }
                        }
                    }

                    markdown.append(model)

                case "    1. ":
                    let stringLine = String(line[line.index(after: prefixEndIndex)..<line.endIndex])
                    let viewModel = createMarkdownViewFrom(line: stringLine,
                                                           codeBlockRanges: stringLine.findRangeOfCode(),
                                                           formulaRanges: stringLine.findRangeOfFormula())

                    var model = MarkdownModel(content: viewModel)
                    model.setFontSizeOfWholeLine(is: CGFloat(fontSize))
                    _ = model.setFirstMarkdownViewType(to: .ordered3)

                    if markdown.count == 0 {
                        _ = model.setOrderedList(number: 0)

                    } else {
                        for elem in markdown.reversed() {
                            if elem.viewTypeOfFirstMarkdownTextView() != .ordered3 &&
                                elem.viewTypeOfFirstMarkdownTextView() != .ordered4 {
                                
                                // Here, we expect the first line to be an ordered line.
                                _ = model.setOrderedList(number: 0)
                                break
                                
                            } else if elem.viewTypeOfFirstMarkdownTextView() == .ordered3 {
                                _ = model.setOrderedList(number: elem.orderedListNumber() + 1)
                                break
                            }
                        }
                    }

                    markdown.append(model)

                case "      1. ":
                    let stringLine = String(line[line.index(after: prefixEndIndex)..<line.endIndex])
                    let viewModel = createMarkdownViewFrom(line: stringLine,
                                                           codeBlockRanges: stringLine.findRangeOfCode(),
                                                           formulaRanges: stringLine.findRangeOfFormula())

                    var model = MarkdownModel(content: viewModel)
                    model.setFontSizeOfWholeLine(is: CGFloat(fontSize))
                    _ = model.setFirstMarkdownViewType(to: .ordered4)

                    if markdown.count == 0 {
                        _ = model.setOrderedList(number: 0)

                    } else {
                        for elem in markdown.reversed() {
                            if elem.viewTypeOfFirstMarkdownTextView() != .ordered4 {
                                
                                // Here, we expect the first line to be an ordered line.
                                _ = model.setOrderedList(number: 0)
                                break
                                
                            } else if elem.viewTypeOfFirstMarkdownTextView() == .ordered4 {
                                _ = model.setOrderedList(number: elem.orderedListNumber() + 1)
                                break
                            }
                        }
                    }

                    markdown.append(model)

                default:
                    let stringLine = String(line)
                    let viewModel = createMarkdownViewFrom(line: stringLine,
                                                           codeBlockRanges: stringLine.findRangeOfCode(),
                                                           formulaRanges: stringLine.findRangeOfFormula())

                    var model = MarkdownModel(content: viewModel)
                    model.setFontSizeOfWholeLine(is: CGFloat(fontSize))
                    markdown.append(model)
                }

            } else {
                let stringLine = String(line)
                let viewModel = createMarkdownViewFrom(line: stringLine,
                                                       codeBlockRanges: stringLine.findRangeOfCode(),
                                                       formulaRanges: stringLine.findRangeOfFormula())

                var model = MarkdownModel(content: viewModel)
                model.setFontSizeOfWholeLine(is: CGFloat(fontSize))
                markdown.append(model)
            }
        }

        return markdown
    }
/*
    private func attributed(headline: Substring, size fontSize: CGFloat) -> AttributedString {
        var attr = AttributedString(removeBlockSyntax(from: String(headline)))
        attr.font = .system(size: fontSize, weight: .bold)

        return attr
    }

    private func attributed(listItem: Substring, size fontSize: CGFloat, dot: String) -> AttributedString {
        let attributedListItem = AttributedString(removeBlockSyntax(from: String(listItem)))
        var attributedDot = AttributedString(dot)
        attributedDot.font = .system(size: fontSize, weight: .heavy)
        attributedDot.append(attributedListItem)

        return attributedDot
    }
*/
    /// Remove the code block ( \`abc\` ) and the formula ((x+y = z)) from the string.
    private func removeBlockSyntax(from line: String) -> String {
        
        let codeBlockRanges = line.findRangeOfCode()
        let formulaRanges = line.findRangeOfFormula()
        
        var trimString: String = ""
        var startIndex = line.startIndex
        
        for codeBlockRange in codeBlockRanges {
            let beforeIndex = line.index(before: codeBlockRange.lowerBound)
            trimString = String(line[startIndex..<beforeIndex])
            
            trimString += " \(line[codeBlockRange]) "

            let afterIndex = line.index(after: codeBlockRange.upperBound)
            trimString += line[afterIndex...]
            
            startIndex = afterIndex
        }

        startIndex = line.startIndex

        for formulaRange in formulaRanges {
            let beforeIndex = line.index(before: formulaRange.formula.lowerBound)
            trimString = String(line[startIndex..<beforeIndex])

            trimString += " \(line[formulaRange.formula])"
            trimString += "\(line[formulaRange.calculateResult]) "

            let afterIndex = line.index(after: formulaRange.calculateResult.upperBound)
            trimString += line[afterIndex...]
            
            startIndex = afterIndex
        }

        return trimString.isEmpty ? line : trimString
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

    /// Create a Markdown view from a Markdown model.
    ///
    /// **How to create MarkdownView**
    /// MarkdownTextView is a struct and is defined in MarkdownModel.swift.
    /// It parses plain text, code blocks, and formulas from the given Markdown text, applies attributes, and creates a MarkdownView.
    /// These attributes are also defined as MarkdownViewType in MarkdownModel.swift.
    ///
    /// Translated by ChatGPT
    /// 1. Based on the array of code block ranges from the given Markdown text,
    ///   create an array of MarkdownTextView instances with plain text attributes and code block attributes.
    /// 2. Prepare a Result array to store the processing results.
    /// 3. In the created array of MarkdownTextView, elements with code block attributes are directly added to the Result array.
    ///   For elements with plain text attributes, further parse them into plain text and formula attributes based on the array of formula block ranges,
    ///   and then add them to the Result array.
    /// 4. Once all processing is complete, the Result array will contain MarkdownTextView instances with plain text attributes,
    ///   code block attributes, or formula attributes, or a combination of these.
    ///
    /// - Parameters:
    ///   - line: The Markdown text.
    ///   - codeBlockRanges: An array of ranges for code blocks contained in the given Markdown text.
    ///   - formulaRanges: An array of ranges for formulas contained in the given Markdown text.
    /// - Returns: An array of MarkdownView.
    ///
    func createMarkdownViewFrom(
        line: String,
        codeBlockRanges: [Range<String.Index>],
        formulaRanges: [(formula: Range<String.Index>, calculateResult: Range<String.Index>)]) -> [MarkdownTextView] {

            guard codeBlockRanges.count != 0 || formulaRanges.count != 0 else {
                return [MarkdownTextView(viewType: .plain, text: line[line.startIndex...])]
            }

            var splitedTextList: [MarkdownTextView] = []

            // 1. Based on the array of code block ranges from the given Markdown text,
            //    create an array of MarkdownTextView instances with plain text attributes and code block attributes.
            
            // e.g.  line = "This is `code block` and (1+2= 3 )!!"

            var startCodeBlockIndex = line.startIndex
            for codeBlockRange in codeBlockRanges {

                // The following extracts "this is".
                if line[startCodeBlockIndex..<line.index(before: codeBlockRange.lowerBound)].count > 0 {
                    splitedTextList.append(MarkdownTextView(
                        viewType: .plain,
                        text: line[startCodeBlockIndex..<line.index(before: codeBlockRange.lowerBound)]))
                }

                // The following extracts "code block".
                splitedTextList.append(MarkdownTextView(viewType: .codeblock, text: line[codeBlockRange]))
                startCodeBlockIndex = line.index(after: codeBlockRange.upperBound)
            }

            // The following extracts " and (1+2= 3 )!!".
            if line[startCodeBlockIndex...].count > 0 {
                splitedTextList.append(MarkdownTextView(viewType: .plain, text: line[startCodeBlockIndex...]))
            }

            // 2. Prepare a Result array to store the processing results.
            var resultSplitedTextList: [MarkdownTextView] = []
            
            // At this point, the "splitedTextList" containes the following elements.
            // splitedTextList = {
            //      MarkdownTextView("This is", MarkdownTextViewType.palin)
            //      MarkdownTextView("code block", MarkdownTextViewType.codeblock)
            //      MarkdownTextView(" and (1+2= 3 )!!", MarkdownTextViewType.palin)
            // }

            // 3. In the created array of MarkdownTextView, elements with code block attributes are directly added to the Result array.
            //    For elements with plain text attributes, further parse them into plain text and formula attributes based on
            //    the array of formula block ranges, and then add them to the Result array.
            for splited in splitedTextList {

                if splited.viewType == .plain {

                    var startFormulaIndex = splited.text.startIndex
                    for formulaRange in formulaRanges {

                        if startFormulaIndex <= formulaRange.formula.lowerBound
                            && formulaRange.calculateResult.upperBound <= splited.text.endIndex {

                            // The following extracts " and ".
                            if splited.text[startFormulaIndex..<splited.text.index(before: formulaRange.formula.lowerBound)].count > 0 {
                                resultSplitedTextList.append(MarkdownTextView(
                                    viewType: .plain,
                                    text: splited.text[startFormulaIndex..<splited.text.index(before: formulaRange.formula.lowerBound)]))
                            }

                            // The following extracts "1+2=".
                            resultSplitedTextList.append(MarkdownTextView(
                                viewType: .formula,
                                text: splited.text[formulaRange.formula]))

                            // The following extracts " 3 ".
                            resultSplitedTextList.append(MarkdownTextView(
                                viewType: .calculationResult,
                                text: splited.text[formulaRange.calculateResult]))

                            startFormulaIndex = splited.text.index(after: formulaRange.calculateResult.upperBound)
                        }
                    }

                    // The following extracts "!!".
                    if splited.text[startFormulaIndex...].count > 0 {
                        resultSplitedTextList.append(MarkdownTextView(
                            viewType: .plain,
                            text: splited.text[startFormulaIndex...]))
                    }

                } else {
                    resultSplitedTextList.append(MarkdownTextView(
                        viewType: splited.viewType,
                        text: splited.text))
                }
            }

            // At this point, the "resultSplitedTextList" containes the following elements.
            // resultSplitedTextList = {
            //      MarkdownTextView("This is", MarkdownTextViewType.palin)
            //      MarkdownTextView("code block", MarkdownTextViewType.codeblock)
            //      MarkdownTextView(" and ", MarkdownTextViewType.palin)
            //      MarkdownTextView("1+2=", MarkdownTextViewType.formula)
            //      MarkdownTextView(" 3 ", MarkdownTextViewType.calculationResult)
            //      MarkdownTextView("!!", MarkdownTextViewType.palin)
            // }

            return resultSplitedTextList
    }

    /// # Return an ordered number
    ///
    /// - Parameters:
    ///   - userInputOrderedList: The user inputed an ordered list with the Markdown.
    ///   - markdown: The Markdown text what splited by "\n".
    /// - Returns: Ordered list number
    func getOrderedNumber(of userInputOrderedList: MarkdownTextViewType, in markdown: [MarkdownModel]) -> Int {
        for elem in markdown.reversed() {
            if elem.viewTypeOfFirstMarkdownTextView() != .ordered1 &&
                elem.viewTypeOfFirstMarkdownTextView() != .ordered2 &&
                elem.viewTypeOfFirstMarkdownTextView() != .ordered3 &&
                elem.viewTypeOfFirstMarkdownTextView() != .ordered4 {
                
                // Here, we expect the first line to be an ordered line.
                return 0

            } else if elem.viewTypeOfFirstMarkdownTextView() == userInputOrderedList {
                return elem.orderedListNumber() + 1
            }
        }
        
        return 0
    }
}
