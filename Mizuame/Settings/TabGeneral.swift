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
        VStack(alignment: .leading) {
            HStack {
                Text("settings.tab.general.menubar")
                Toggle(isOn: $isShowSavingMessage) {
                    Text("settings.tab.general.menubar.saving")
                }
            }

            HStack {
                Text("pinning")
                Toggle(isOn: $isPinNote) {
                    Text("pinning")
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
        .frame(width: 400, height: 200)
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
    }
}

struct TabStickyNote_Previews: PreviewProvider {
    static var previews: some View {
        TabGeneral()
    }
}
