//
//  MarkdownStyling.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2024/09/29.
//

import Foundation
import SwiftUI

extension View {

    /// Create an AttributedString from a Markdown model.
    /// - Parameters:
    ///   - text: The Markdown string to be converted.
    ///   - codeBlockTheme: The background color to apply to code blocks.
    ///   - formulaBlockTheme: The background color to apply to formula blocks.
    /// - Returns: An AttributedString with applied styles.
    ///
    func convertMarkdownTextToAttributedString(text: String, codeBlockTheme: String, formulaBlockTheme: String) -> AttributedString {

        let markdownModels: [MarkdownModel] = text.toMarkdown(size: 12)

        var markdownText: AttributedString = AttributedString()

        for md in markdownModels {

            var attributedLine = md.attributedLine

            for codeBlockRange in md.codeBlockRanges {
                if let attributedCodeBlockRange = attributedLine.range(of: md.line[codeBlockRange]) {
                    attributedLine[attributedCodeBlockRange].backgroundColor = Color(codeBlockTheme)
                }
            }

            for formulaRange in md.formulaRanges {
                if let attributedFormulaRange = attributedLine.range(of: md.line[formulaRange.formula.lowerBound..<formulaRange.calculateResult.upperBound]) {

                    attributedLine[attributedFormulaRange].backgroundColor = Color(formulaBlockTheme)
                }
            }

            markdownText.append(attributedLine)
        }
        
        return markdownText
    }
}
