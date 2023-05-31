//
//  TabGeneral.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/25.
//

import SwiftUI
import StoreKit

struct TabGeneral: View {
    @AppStorage(SettingKeys.FontSize().key) private var fontSize: Int = SettingKeys.FontSize().initialValue

    @AppStorage(SettingKeys.MessageColor().keyR) private var msgR: Double = SettingKeys.MessageColor().initialR
    @AppStorage(SettingKeys.MessageColor().keyG) private var msgG: Double = SettingKeys.MessageColor().initialG
    @AppStorage(SettingKeys.MessageColor().keyB) private var msgB: Double = SettingKeys.MessageColor().initialB

    @AppStorage(SettingKeys.MessagebarColor().keyR) private var barR: Double = SettingKeys.MessagebarColor().initialR
    @AppStorage(SettingKeys.MessagebarColor().keyG) private var barG: Double = SettingKeys.MessagebarColor().initialG
    @AppStorage(SettingKeys.MessagebarColor().keyB) private var barB: Double = SettingKeys.MessagebarColor().initialB

    private let INIT_FONT_SIZE: Int = SettingKeys.FontSize().initialValue
    private let INIT_MSG_COLOR_R: Double = SettingKeys.MessageColor().initialR
    private let INIT_MSG_COLOR_G: Double = SettingKeys.MessageColor().initialG
    private let INIT_MSG_COLOR_B: Double = SettingKeys.MessageColor().initialB
    private let INIT_MSGBAR_COLOR_R: Double = SettingKeys.MessagebarColor().initialR
    private let INIT_MSGBAR_COLOR_G: Double = SettingKeys.MessagebarColor().initialG
    private let INIT_MSGBAR_COLOR_B: Double = SettingKeys.MessagebarColor().initialB

    var body: some View {
        VStack {
            StickyNotePreview(fontSize: fontSize, msgR: msgR, msgG: msgG, msgB: msgB, barR: barR, barG: barG, barB: barB)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            
            ScrollView {
                VStack(alignment: .leading) {
                    Picker("Font Size: ", selection: $fontSize) {
                        ForEach(1..<40, id: \.self) { num in
                            Text("\(num)")
                        }
                    }
                    .frame(width: 150)
                    
                    ColorSliderView(title: "Message Font Color:", rr: $msgR, gg: $msgG, bb: $msgB)
                    
                    ColorSliderView(title: "Messagebar Color:", rr: $barR, gg: $barG, bb: $barB)
                    
                    Spacer()
                    
                    Text("Reset: ")
                    Button(action: {
                        self.fontSize = INIT_FONT_SIZE
                        self.msgR = INIT_MSG_COLOR_R
                        self.msgG = INIT_MSG_COLOR_G
                        self.msgB = INIT_MSG_COLOR_B
                        self.barR = INIT_MSGBAR_COLOR_R
                        self.barG = INIT_MSGBAR_COLOR_G
                        self.barB = INIT_MSGBAR_COLOR_B
                    }) {
                        Text("Reset Font style to initial value")
                            .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
                    }
                }
            }
            .padding(EdgeInsets(top: 10, leading: 50, bottom: 20, trailing: 50))
        }
        .frame(width: 400, height: 400)
    }
}

struct TabGeneral_Previews: PreviewProvider {
    static var previews: some View {
        TabGeneral()
    }
}
