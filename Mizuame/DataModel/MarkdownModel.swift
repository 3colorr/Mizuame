//
//  MarkdownModel.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2024/09/22.
//

import Foundation

enum MarkdownTextViewType {
    case plain
    case codeblock
    case formula
    case header1
    case header2
    case header3
    case header4
    case header5
    case header6
    case list1
    case list2
    case list3
    case list4
}

struct MarkdownTextView: Identifiable {
    let id = UUID()
    var text: Substring
    var attributedText: AttributedString
    var viewType: MarkdownTextViewType
    var fontSize: CGFloat

    init(viewType: MarkdownTextViewType, text: Substring) {
        self.viewType = viewType
        self.text = text
        self.fontSize = 0

        do {
            attributedText = try AttributedString(markdown: String(text))
        } catch {
            attributedText = AttributedString(text)
        }
    }
}

struct MarkdownModel: Identifiable {
    let id = UUID()
    var markdownTextViews: [MarkdownTextView]

    init(content: [MarkdownTextView]) {
        self.markdownTextViews = content
    }

    mutating func setFontSizeOfWholeLine(is fontSize: CGFloat) {
        for i in 0..<markdownTextViews.count {
            markdownTextViews[i].fontSize = fontSize
        }
    }

    mutating func setFirstMarkdownViewType(to newViewType: MarkdownTextViewType) -> Bool {
        guard markdownTextViews.count != 0 else {
            return false
        }

        markdownTextViews[0].viewType = newViewType
        return true
    }
}
