//
//  MarkdownModel.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2024/09/22.
//

import Foundation

struct MarkdownModel {
    var line: String
    var attributedLine: AttributedString
    var codeBlockRanges: [Range<String.Index>]
    var formulaRanges: [(formula: Range<String.Index>, calculateResult: Range<String.Index>)]
    
    init(line: String,
         attributedLine: AttributedString,
         codeBlockRanges: [Range<String.Index>],
         formulaRanges: [(formula: Range<String.Index>, calculateResult: Range<String.Index>)]) {
        
        self.line = "\(line)\n"
        self.codeBlockRanges = codeBlockRanges
        self.formulaRanges = formulaRanges

        self.attributedLine = attributedLine
        self.attributedLine.append(AttributedString("\n"))
    }

    func hasCodeBlock() -> Bool {
        return (codeBlockRanges.count > 0)
    }

    func hasFormulaBlock() -> Bool {
        return (formulaRanges.count > 0)
    }

    func isApplyCodeBlock() -> Bool {
        return (codeBlockRanges.count > 0) && (formulaRanges.count == 0)
    }

    func isApplyFormulaRange() -> Bool {
        return (codeBlockRanges.count == 0) && (formulaRanges.count > 0)
    }
}
