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

    @AppStorage(SettingKeys.StickyNote().keyWidth) private var width: Int =  SettingKeys.StickyNote().initialWidth
    @AppStorage(SettingKeys.StickyNote().keyHeight) private var height: Int = SettingKeys.StickyNote().initialHeight

    @AppStorage(SettingKeys.MessageColor().keyTheme) private var msgTheme: String = SettingKeys.MessageColor().initialTheme
    @AppStorage(SettingKeys.MessagebarColor().keyTheme) private var barTheme: String = SettingKeys.MessagebarColor().initialTheme

    private let INIT_FONT_SIZE: Int = SettingKeys.FontSize().initialValue
    private let INIT_WIDTH: Int = SettingKeys.StickyNote().initialWidth
    private let INIT_HEIGHT: Int = SettingKeys.StickyNote().initialHeight
    private let INIT_MSG_THEME: String = SettingKeys.ThemePalette.LightMint().message
    private let INIT_BAR_THEME: String = SettingKeys.ThemePalette.LightMint().messagebar

    private var numberFormatter = NumberFormatter()

    init() {
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.maximumIntegerDigits = 4
    }

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("settings.tab.stickynote.greeting")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 5, trailing: 0))
            }
            
            StickyNotePreview(fontSize: fontSize, width: width, height: height, msg: msgTheme, bar: barTheme)
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 10, trailing: 0))
            
            ScrollView {
                VStack(alignment: .leading) {
                    Picker("settings.tab.stickynote.font.size", selection: $fontSize) {
                        ForEach(1..<40, id: \.self) { num in
                            Text("\(num)")
                        }
                    }
                    .frame(width: 150)
                    
                    Text("settings.tab.stickynote.window.size")
                    
                    HStack {
                        Text("settings.tab.stickynote.window.size.width")
                        TextField("\(INIT_WIDTH)", value: $width, formatter: NumberFormatter())
                            .frame(width: 80)
                            .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 10))
                            .onChange(of: width) { val in
                                if val < SettingKeys.StickyNote().minWidth {
                                    width = SettingKeys.StickyNote().minWidth
                                }
                                if val > SettingKeys.StickyNote().maxWidth {
                                    width = SettingKeys.StickyNote().maxWidth
                                }
                            }
                        
                        Text("settings.tab.stickynote.window.size.height")
                        TextField("\(INIT_HEIGHT)", value: $height, formatter: NumberFormatter())
                            .frame(width: 80)
                            .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 0))
                            .onChange(of: height) { val in
                                if val < SettingKeys.StickyNote().minHeight {
                                    height = SettingKeys.StickyNote().minHeight
                                }
                                if val > SettingKeys.StickyNote().maxHeight {
                                    height = SettingKeys.StickyNote().maxHeight
                                }
                            }
                    }
                    
                    Text("settings.tab.stickynote.theme")
                    ThemePalette(msg: $msgTheme, msgbar: $barTheme, checked: msgTheme)
                     
                    Spacer()
                    
                    Text("settings.tab.stickynote.reset.title")
                    Button(action: {
                        self.fontSize = INIT_FONT_SIZE
                        self.width = INIT_WIDTH
                        self.height = INIT_HEIGHT
                        self.msgTheme = INIT_MSG_THEME
                        self.barTheme = INIT_BAR_THEME
                    }) {
                        Text("settings.tab.stickynote.reset.button.caption")
                            .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
                    }
                }
            }
            .padding(EdgeInsets(top: 10, leading: 50, bottom: 20, trailing: 50))
        }
        .frame(width: 400, height: 500)
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
