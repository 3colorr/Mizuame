//
//  TabGeneral.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/25.
//

import SwiftUI
import StoreKit

struct TabGeneral: View {
    
    @EnvironmentObject var delegate: AppDelegate
    
    @AppStorage(SettingKeys.Menubar().keySavingMessage) private var isShowSavingMessage: Bool = SettingKeys.Menubar().initialSavingMessage

    @AppStorage(SettingKeys.StickyNote().keyPinNote) private var isPinNote: Bool = SettingKeys.StickyNote().initialPinNote

    @AppStorage(SettingKeys.StickyNote.NoteFontColor.Theme().key) private var isApplyThemeColorToFont: Bool = SettingKeys.StickyNote.NoteFontColor.Theme().initialVale

    @AppStorage(SettingKeys.StickyNote.NoteFontColor.Black().key) private var isApplyBlackColorToFont: Bool = SettingKeys.StickyNote.NoteFontColor.Black().initialVale

    @AppStorage(SettingKeys.StickyNote.NoteFontColor.DarkGray().key) private var isApplyDarkGrayColorToFont: Bool = SettingKeys.StickyNote.NoteFontColor.DarkGray().initialVale

    @AppStorage(SettingKeys.StickyNote.NoteFontColor.Gray().key) private var isApplyGrayColorToFont: Bool = SettingKeys.StickyNote.NoteFontColor.Gray().initialVale

    @AppStorage(SettingKeys.StickyNote().keyCalculateAction) private var isEnableCalculation: Bool = SettingKeys.StickyNote().initialCalculateAction

    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 30) {
                HStack(alignment: .top) {
                    Text("settings.tab.general.note.title")
                        .frame(width: 100, alignment: .leading)

                    VStack(alignment: .leading) {
                        Toggle(isOn: $isShowSavingMessage) {
                            Text("settings.tab.general.note.menubar.saving")
                        }
                        
                        Toggle(isOn: $isPinNote) {
                            Text("settings.tab.general.note.note.pin")
                        }
                        .onChange(of: isPinNote) { isPinning in
                            if isPinning {
                                delegate.enablePinning()
                            } else {
                                delegate.disablePinning()
                            }
                        }
                        
                        Spacer()
                    }
                }
                
                HStack {
                    VStack {
                        Text("settings.tab.general.action.title")
                        Spacer()
                    }
                    .frame(width: 100, alignment: .leading)

                    VStack(alignment: .leading) {
                        Toggle(isOn: $isEnableCalculation) {
                            Text("settings.tab.general.action.calculate")
                        }
                        
                        Text("settings.tab.help.note.action.calculate.description")
                            .font(.caption)
                    }
                }
            }
            
            Spacer()
            
            HStack {
                Text("settings.tab.general.reset.title")
                    .frame(width: 100, alignment: .leading)

                Button(action: {
                    self.isShowSavingMessage = SettingKeys.Menubar().initialSavingMessage
                    self.isPinNote = SettingKeys.StickyNote().initialPinNote
                }) {
                    Text("settings.tab.general.reset.button.caption")
                        .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
                }
            }
        }
        .frame(width: 450, height: 300)
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
    }
}

struct TabStickyNote_Previews: PreviewProvider {
    static var previews: some View {
        let localizations = ["en", "ja"]
        ForEach(localizations, id: \.self) { lang in
            TabGeneral()
                .previewDisplayName("lcal:\(lang)")
                .environment(\.locale, .init(identifier: lang))
        }
    }
}
