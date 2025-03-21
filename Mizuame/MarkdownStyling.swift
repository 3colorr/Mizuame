//
//  MarkdownStyling.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2024/09/29.
//

import Foundation
import SwiftUI

extension View {

    /// Create a Markdown view.
    /// - Parameters:
    ///   - text: The Markdown string to be converted.
    ///   - fontSize: The font size of the Markdown text.
    ///   - codeBlockTheme: The background color to apply to code blocks.
    ///   - formulaBlockTheme: The background color to apply to formula blocks.
    /// - Returns: A View with applied styles.
    ///
    func convertMarkdownTextToView(text: String, fontSize: Int, codeBlockTheme: String, formulaBlockTheme: String, lineSpacing: CGFloat) -> some View {

        let initialFontSize = CGFloat(SettingKeys.FontSize().initialValue)
        let markdownModels: [MarkdownModel] = text.toMarkdown(size: fontSize)

        return VStack(alignment: .leading, spacing: lineSpacing) {
            ForEach(markdownModels) { md in
                HStack(spacing: 0) {
                    ForEach(md.markdownTextViews) { elem in
                        switch elem.viewType {
                        case MarkdownTextViewType.plain:
                            Text(elem.attributedText)
                                .font(.system(size: elem.fontSize))

                        case MarkdownTextViewType.codeblock:
                            Text(" \(elem.text) ")
                                .font(.system(size: elem.fontSize))
                                .background(Color(codeBlockTheme), in: RoundedRectangle(cornerRadius: 3))
                                .padding(EdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 3))

                        case MarkdownTextViewType.formula:
                            Text("  \(elem.text)  ")
                                .font(.system(size: elem.fontSize))
                                .background(Color(formulaBlockTheme), in: RoundedRectangle(cornerRadius: 3))
                                .padding(EdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 0))
                            
                        case MarkdownTextViewType.calculationResult:
                            Text("\(elem.text)")
                                .font(.system(size: elem.fontSize))
                                .background(Color(codeBlockTheme), in: RoundedRectangle(cornerRadius: 3))
                                .padding(EdgeInsets(top: 0, leading: -5, bottom: 0, trailing: 0))
                            
                        case MarkdownTextViewType.header1:
                            Text(elem.attributedText)
                                .font(.system(size: elem.fontSize))
                            
                        case MarkdownTextViewType.header2:
                            Text(elem.attributedText)
                                .font(.system(size: elem.fontSize))
                            
                        case MarkdownTextViewType.header3:
                            Text(elem.attributedText)
                                .font(.system(size: elem.fontSize))
                            
                        case MarkdownTextViewType.header4:
                            Text(elem.attributedText)
                                .font(.system(size: elem.fontSize))
                            
                        case MarkdownTextViewType.header5:
                            Text(elem.attributedText)
                                .font(.system(size: elem.fontSize))
                            
                        case MarkdownTextViewType.header6:
                            Text(elem.attributedText)
                                .font(.system(size: elem.fontSize))
                            
                        case MarkdownTextViewType.list1:
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 5 * (elem.fontSize / initialFontSize),
                                       height: 5 * (elem.fontSize / initialFontSize))
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 8))
                            Text(elem.attributedText)
                                .font(.system(size: elem.fontSize))
                            
                        case MarkdownTextViewType.list2:
                            Image(systemName: "circle")
                                .resizable()
                                .frame(width: 5 * (elem.fontSize / initialFontSize),
                                       height: 5 * (elem.fontSize / initialFontSize))
                                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 8))
                            Text(elem.attributedText)
                                .font(.system(size: elem.fontSize))
                            
                        case MarkdownTextViewType.list3:
                            Image(systemName: "square.fill")
                                .resizable()
                                .frame(width: 5 * (elem.fontSize / initialFontSize),
                                       height: 5 * (elem.fontSize / initialFontSize))
                                .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 8))
                            Text(elem.attributedText)
                                .font(.system(size: elem.fontSize))
                            
                        case MarkdownTextViewType.list4:
                            Image(systemName: "square")
                                .resizable()
                                .frame(width: 5 * (elem.fontSize / initialFontSize),
                                       height: 5 * (elem.fontSize / initialFontSize))
                                .padding(EdgeInsets(top: 0, leading: 70, bottom: 0, trailing: 8))
                            Text(elem.attributedText)
                                .font(.system(size: elem.fontSize))

                        case .ordered1:
                            Text("\(elem.orderedListNumber + 1).")
                                .font(.system(size: elem.fontSize))
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 5))
                            Text(elem.attributedText)
                                .font(.system(size: elem.fontSize))

                        case .ordered2:
                            Text("\(elem.orderedListNumber + 1).")
                                .font(.system(size: elem.fontSize))
                                .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 5))
                            Text(elem.attributedText)
                                .font(.system(size: elem.fontSize))

                        case .ordered3:
                            Text("\(elem.orderedListNumber + 1).")
                                .font(.system(size: elem.fontSize))
                                .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 5))
                            Text(elem.attributedText)
                                .font(.system(size: elem.fontSize))

                        case .ordered4:
                            Text("\(elem.orderedListNumber + 1).")
                                .font(.system(size: elem.fontSize))
                                .padding(EdgeInsets(top: 0, leading: 55, bottom: 0, trailing: 5))
                            Text(elem.attributedText)
                                .font(.system(size: elem.fontSize))
                        }
                    }
                }
            }
        }
    }
}
