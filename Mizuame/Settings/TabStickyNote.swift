//
//  TabStickyNote.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/25.
//

import SwiftUI
import StoreKit

struct TabStickyNote: View {
    @AppStorage(SettingKeys.FontSize().key) private var fontSize: Int = SettingKeys.FontSize().initialValue
    @AppStorage(SettingKeys.StickyNote().keyLineSpacing) private var lineSpacing: Int = SettingKeys.StickyNote().initialLineSpacing

    @AppStorage(SettingKeys.StickyNote().keyWidth) private var width: Int =  SettingKeys.StickyNote().initialWidth
    @AppStorage(SettingKeys.StickyNote().keyHeight) private var height: Int = SettingKeys.StickyNote().initialHeight

    @AppStorage(SettingKeys.MessageColor().keyTheme) private var messageTheme: String = SettingKeys.MessageColor().initialTheme
    @AppStorage(SettingKeys.MessagebarColor().keyTheme) private var messagebarTheme: String = SettingKeys.MessagebarColor().initialTheme

    @AppStorage(SettingKeys.StickyNoteColor().keyForeground) private var bodyForegroundTheme: String = SettingKeys.StickyNoteColor().initialForegroundTheme
    @AppStorage(SettingKeys.StickyNoteColor().keyBackground) private var bodyBackgroundTheme: String = SettingKeys.StickyNoteColor().initialBackgroundTheme

    @AppStorage(SettingKeys.FrameColor().keyTheme) private var frameTheme: String = SettingKeys.FrameColor().initialTheme

    @AppStorage(SettingKeys.MarkdownViewColor().keyCodeBlock) private var markdownCodeBlockTheme: String = SettingKeys.MarkdownViewColor().initialCodeBlockTheme
    @AppStorage(SettingKeys.MarkdownViewColor().keyFormulaBlock) private var markdownFormulaBlockTheme: String = SettingKeys.MarkdownViewColor().initialFormulaBlockTheme

    private let INIT_FONT_SIZE: Int = SettingKeys.FontSize().initialValue
    private let INIT_LINE_SPACING: Int = SettingKeys.StickyNote().initialLineSpacing
    private let INIT_WIDTH: Int = SettingKeys.StickyNote().initialWidth
    private let INIT_HEIGHT: Int = SettingKeys.StickyNote().initialHeight
    private let INIT_MESSAGE_THEME: String = SettingKeys.MessageColor().initialTheme
    private let INIT_MESSAGEBAR_THEME: String = SettingKeys.MessagebarColor().initialTheme
    private let INIT_BODY_FOREGROUND_THEME: String = SettingKeys.StickyNoteColor().initialForegroundTheme
    private let INIT_BODY_BACKGROUND_THEME: String = SettingKeys.StickyNoteColor().initialBackgroundTheme
    private let INIT_FRAME_THEME: String = SettingKeys.FrameColor().initialTheme

    private let INIT_MARKDOWN_CODEBLOCK_THEME: String = SettingKeys.MarkdownViewColor().initialCodeBlockTheme
    private let INIT_MARKDOWN_FORMULABLOCK_THEME: String = SettingKeys.MarkdownViewColor().initialFormulaBlockTheme

    private var noteWidthFormatter = NumberFormatter()
    private var noteHeightFormatter = NumberFormatter()

    init() {
        noteWidthFormatter.minimumIntegerDigits = 1
        noteWidthFormatter.maximumIntegerDigits = 4
        noteWidthFormatter.minimum = SettingKeys.StickyNote().minWidth
        noteWidthFormatter.maximum = SettingKeys.StickyNote().maxWidth
        
        noteHeightFormatter.minimumIntegerDigits = 1
        noteHeightFormatter.maximumIntegerDigits = 4
        noteHeightFormatter.minimum = SettingKeys.StickyNote().minHeight
        noteHeightFormatter.maximum = SettingKeys.StickyNote().maxHeight
    }

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("settings.tab.stickynote.greeting")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 5, trailing: 0))
            }
            
            StickyNotePreview(fontSize: fontSize,
                              width: width,
                              height: height,
                              message: messageTheme,
                              messagebar: messagebarTheme,
                              bodyForeground: bodyForegroundTheme,
                              bodyBackground: bodyBackgroundTheme,
                              bodyFrame: frameTheme)
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 10, trailing: 0))
            
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text("settings.tab.stickynote.font.size")
                            .frame(width: 100, alignment: .leading)

                        Picker("", selection: $fontSize) {
                            ForEach(1..<41, id: \.self) { num in
                                Text("\(num)")
                            }
                        }
                        .frame(width: 60)
                    }

                    HStack {
                        Text("settings.tab.stickynote.linespacing")
                            .frame(width: 100, alignment: .leading)
                        
                        Picker("", selection: $lineSpacing) {
                            ForEach(0..<21, id: \.self) { num in
                                Text("\(num)")
                            }
                        }
                        .frame(width: 60)
                    }

                    HStack {
                        Text("settings.tab.stickynote.window.size")
                            .frame(width: 100, alignment: .leading)
                        
                        HStack {
                            Text("settings.tab.stickynote.window.size.width")
                                .frame(width: 60)

                            TextField("\(INIT_WIDTH)", value: $width, formatter: noteWidthFormatter)
                                .frame(width: 60)
                                .padding(EdgeInsets(top: 0, leading: -10, bottom: 0, trailing: 0))
                        }
                        
                        HStack {
                            Text("settings.tab.stickynote.window.size.height")
                                .frame(width: 50)

                            TextField("\(INIT_HEIGHT)", value: $height, formatter: noteHeightFormatter)
                                .frame(width: 60)
                                .padding(EdgeInsets(top: 0, leading: -5, bottom: 0, trailing: 0))
                        }
                    }
                    
                    Text("settings.tab.stickynote.theme")
                    ThemePalette(message: $messageTheme,
                                 messagebar: $messagebarTheme,
                                 bodyForeground: $bodyForegroundTheme,
                                 bodyBackground: $bodyBackgroundTheme,
                                 bodyFrame: $frameTheme,
                                 markdownCodeBlock: $markdownCodeBlockTheme,
                                 markdownFormulaBlock: $markdownFormulaBlockTheme)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                     
                    Spacer(minLength: 20)
                    
                    HStack {
                        Text("settings.tab.stickynote.reset.title")
                        Button(action: {
                            self.fontSize = INIT_FONT_SIZE
                            self.lineSpacing = INIT_LINE_SPACING
                            self.width = INIT_WIDTH
                            self.height = INIT_HEIGHT
                            self.messageTheme = INIT_MESSAGE_THEME
                            self.messagebarTheme = INIT_MESSAGEBAR_THEME
                            self.bodyForegroundTheme = INIT_BODY_FOREGROUND_THEME
                            self.bodyBackgroundTheme = INIT_BODY_BACKGROUND_THEME
                            self.frameTheme = INIT_FRAME_THEME
                            self.markdownCodeBlockTheme = INIT_MARKDOWN_CODEBLOCK_THEME
                            self.markdownFormulaBlockTheme = INIT_MARKDOWN_FORMULABLOCK_THEME
                        }) {
                            Text("settings.tab.stickynote.reset.button.caption")
                                .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
                        }
                    }
                }
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
        }
    }
}

struct TabGeneral_Previews: PreviewProvider {
    static var previews: some View {
        let localizations = ["en", "ja"]
        ForEach(localizations, id: \.self) { lang in
            TabStickyNote()
                .previewDisplayName("lcal:\(lang)")
                .environment(\.locale, .init(identifier: lang))
        }
    }
}
