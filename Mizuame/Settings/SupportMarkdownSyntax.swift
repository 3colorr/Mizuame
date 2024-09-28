//
//  SupportMarkdownSyntax.swift
//  Mizuame
//
//  Created by becomefoolish on 2024/09/15.
//

import SwiftUI

struct SupportMarkdownSyntax: View {

    @AppStorage(SettingKeys.FontSize().key) private var fontSize: Int = SettingKeys.FontSize().initialValue

    let headerSyntax = "# header 1\n## header 2\n### header 3\n#### header 4\n##### header 5\n###### header 6"

    let listSyntax = """
        - list1
          - list 2
            - list 3
        """

    let boldSyntax = "**Bold**"
    let itaricSyntax = "_Itaric_"
    let linkSyntax = "Link(URL)"
    let codeBlockSyntax = "`Code Block`"
    let formulaBlockSyntax = "(1+2= 3 )"

    var body: some View {
        HStack(alignment: .top) {
            SyntaxBlock(
                eg: Text(verbatim: headerSyntax),
                markdown: Text(markdown(of: headerSyntax)))

            SyntaxBlock(
                eg: Text(verbatim: listSyntax),
                markdown: Text(markdown(of: listSyntax)))

            VStack(alignment: .leading, spacing: 10) {
                SyntaxBlock(
                    eg: Text(verbatim: boldSyntax),
                    markdown: Text(markdown(of: boldSyntax)))

                SyntaxBlock(
                    eg: Text(verbatim: itaricSyntax),
                    markdown: Text(markdown(of: itaricSyntax)))

                SyntaxBlock(
                    eg: Text(verbatim: linkSyntax),
                    markdown: Text(markdown(of: linkSyntax)))

                SyntaxBlock(
                    eg: Text(verbatim: codeBlockSyntax),
                    markdown: Text(markdown(of: codeBlockSyntax)))

                SyntaxBlock(
                    eg: Text(verbatim: formulaBlockSyntax),
                    markdown: Text(markdown(of: formulaBlockSyntax)))
            }
        }
    }

    private func SyntaxBlock(eg: Text, markdown: Text) -> some View {
        VStack {
            eg
            markdown
        }
        .padding(15)
        .background(.white, in: RoundedRectangle(cornerRadius: 10))
    }

    private func markdown(of syntax: String) -> AttributedString {
        
        let markdownModels: [MarkdownModel] = syntax.toMarkdown(size: self.fontSize)

        var markdownText: AttributedString = AttributedString()

        for md in markdownModels {

            var attributedLine = md.attributedLine

            for codeBlockRange in md.codeBlockRanges {
                if let attributedCodeBlockRange = attributedLine.range(of: md.line[codeBlockRange]) {
                    attributedLine[attributedCodeBlockRange].backgroundColor = Color(red: 0.9, green: 0.9, blue: 0.9)
                }
            }

            for formulaRange in md.formulaRanges {
                if let attributedFormulaRange = attributedLine.range(of: md.line[formulaRange.formula.lowerBound..<formulaRange.calculateResult.upperBound]) {

                    attributedLine[attributedFormulaRange].backgroundColor = Color(red: 0.9, green: 0.9, blue: 0.8)
                }
            }

            markdownText.append(attributedLine)
        }

        return markdownText
    }
}

#Preview {
    SupportMarkdownSyntax()
}
