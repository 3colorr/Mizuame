//
//  TabGeneral.swift
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

    @AppStorage(SettingKeys.MessageColor().keyR) private var msgR: Double = SettingKeys.MessageColor().initialR
    @AppStorage(SettingKeys.MessageColor().keyG) private var msgG: Double = SettingKeys.MessageColor().initialG
    @AppStorage(SettingKeys.MessageColor().keyB) private var msgB: Double = SettingKeys.MessageColor().initialB

    @AppStorage(SettingKeys.MessagebarColor().keyR) private var barR: Double = SettingKeys.MessagebarColor().initialR
    @AppStorage(SettingKeys.MessagebarColor().keyG) private var barG: Double = SettingKeys.MessagebarColor().initialG
    @AppStorage(SettingKeys.MessagebarColor().keyB) private var barB: Double = SettingKeys.MessagebarColor().initialB

    private let INIT_FONT_SIZE: Int = SettingKeys.FontSize().initialValue
    private let INIT_WIDTH: Int = SettingKeys.StickyNote().initialWidth
    private let INIT_HEIGHT: Int = SettingKeys.StickyNote().initialHeight
    private let INIT_MSG_COLOR_R: Double = SettingKeys.MessageColor().initialR
    private let INIT_MSG_COLOR_G: Double = SettingKeys.MessageColor().initialG
    private let INIT_MSG_COLOR_B: Double = SettingKeys.MessageColor().initialB
    private let INIT_MSGBAR_COLOR_R: Double = SettingKeys.MessagebarColor().initialR
    private let INIT_MSGBAR_COLOR_G: Double = SettingKeys.MessagebarColor().initialG
    private let INIT_MSGBAR_COLOR_B: Double = SettingKeys.MessagebarColor().initialB

    private var numberFormatter = NumberFormatter()

    init() {
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.maximumIntegerDigits = 4
    }

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Previews:\nSize is NOT correct. Check the real size. Sorry!")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 5, trailing: 0))
            }
            
            StickyNotePreview(fontSize: fontSize, width: width, height: height, msgR: msgR, msgG: msgG, msgB: msgB, barR: barR, barG: barG, barB: barB)
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 10, trailing: 0))
            
            ScrollView {
                VStack(alignment: .leading) {
                    Picker("Font Size: ", selection: $fontSize) {
                        ForEach(1..<40, id: \.self) { num in
                            Text("\(num)")
                        }
                    }
                    .frame(width: 150)
                    
                    Text("Sticky Note Size:")
                    
                    HStack {
                        Text("Width:")
                        TextField("e.g. \(INIT_WIDTH)", value: $width, formatter: NumberFormatter())
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
                        
                        Text("Height:")
                        TextField("e.g. \(INIT_HEIGHT)", value: $height, formatter: NumberFormatter())
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
                    
                    ColorSliderView(title: "Message Font Color:", rr: $msgR, gg: $msgG, bb: $msgB)
                    
                    ColorSliderView(title: "Messagebar Color:", rr: $barR, gg: $barG, bb: $barB)
                    
                    Spacer()
                    
                    Text("Reset: ")
                    Button(action: {
                        self.fontSize = INIT_FONT_SIZE
                        self.width = INIT_WIDTH
                        self.height = INIT_HEIGHT
                        self.msgR = INIT_MSG_COLOR_R
                        self.msgG = INIT_MSG_COLOR_G
                        self.msgB = INIT_MSG_COLOR_B
                        self.barR = INIT_MSGBAR_COLOR_R
                        self.barG = INIT_MSGBAR_COLOR_G
                        self.barB = INIT_MSGBAR_COLOR_B
                    }) {
                        Text("Reset windowd style to initial value")
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
        TabGeneral()
    }
}
