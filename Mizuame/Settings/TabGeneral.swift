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

    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text("settings.tab.general.note.title")
                    .bold()

                HStack {
                    Text("settings.tab.general.note.menubar")
                        .frame(width: 100, alignment: .leading)
                    Toggle(isOn: $isShowSavingMessage) {
                        Text("settings.tab.general.note.menubar.saving")
                    }
                }

                HStack {
                    Text("settings.tab.general.note.note")
                        .frame(width: 100, alignment: .leading)
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
        .frame(width: 400, height: 200)
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
