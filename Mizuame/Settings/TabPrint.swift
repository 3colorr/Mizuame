//
//  TabPrint.swift
//  Mizuame
//
//  Created by becomefoolish on 2023/07/09.
//

import SwiftUI

struct TabPrint: View {
    
    @AppStorage(SettingKeys.Printer().keyTopMargin) private var imageTopMargin: Int = SettingKeys.Printer().initialTopMargin
    @AppStorage(SettingKeys.Printer().keyBottomMargin) private var imageBottomMargin: Int = SettingKeys.Printer().initialBottomMargin
    @AppStorage(SettingKeys.Printer().keyLeftMargin) private var imageLeftMargin: Int = SettingKeys.Printer().initialLeftMargin
    @AppStorage(SettingKeys.Printer().keyRightMargin) private var imageRightMargin: Int = SettingKeys.Printer().initialRightMargin

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("settings.tab.general.menubar")
            }
        }
        .frame(width: 400, height: 200)
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
    }
}

struct TabPrint_Previews: PreviewProvider {
    static var previews: some View {
        TabPrint()
    }
}
