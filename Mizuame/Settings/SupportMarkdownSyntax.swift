//
//  SupportMarkdownSyntax.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2024/09/15.
//

import SwiftUI

struct SupportMarkdownSyntax: View {

    @AppStorage(SettingKeys.StickyNoteColor().keyBackground) private var bodyBackgroundTheme: String = SettingKeys.StickyNoteColor().initialBackgroundTheme
    @AppStorage(SettingKeys.FontSize().key) private var fontSize: Int = SettingKeys.FontSize().initialValue

    @AppStorage(SettingKeys.MarkdownViewColor().keyCodeBlock) private var markdownCodeBlockTheme: String = SettingKeys.MarkdownViewColor().initialCodeBlockTheme
    @AppStorage(SettingKeys.MarkdownViewColor().keyFormulaBlock) private var markdownFormulaBlockTheme: String = SettingKeys.MarkdownViewColor().initialFormulaBlockTheme

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
            SyntaxBlock(markdown: headerSyntax)
            SyntaxBlock(markdown: listSyntax)

            VStack(alignment: .leading, spacing: 10) {
                SyntaxBlock(markdown: boldSyntax)
                SyntaxBlock(markdown: itaricSyntax)
                SyntaxBlock(markdown: codeBlockSyntax)
                SyntaxBlock(markdown: formulaBlockSyntax)
            }
        }
    }

    private func SyntaxBlock(markdown: String) -> some View {
        VStack {
            Text(verbatim: markdown)
                .font(.system(size: CGFloat(fontSize)))

            convertMarkdownTextToView(
                text: markdown,
                fontSize: fontSize,
                codeBlockTheme: markdownCodeBlockTheme,
                formulaBlockTheme: markdownFormulaBlockTheme)
        }
        .padding(15)
        .background(Color(bodyBackgroundTheme), in: RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    SupportMarkdownSyntax()
}
