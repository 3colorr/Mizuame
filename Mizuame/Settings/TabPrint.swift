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
    
    private let INIT_TOP_MARGIN: Int = SettingKeys.Printer().initialTopMargin
    private let INIT_BOTTOM_MARGIN: Int = SettingKeys.Printer().initialBottomMargin
    private let INIT_LEFT_MARGIN: Int = SettingKeys.Printer().initialLeftMargin
    private let INIT_RIGHT_MARGIN: Int = SettingKeys.Printer().initialRightMargin

    var body: some View {
        VStack(alignment: .leading) {
            Text("settings.tab.print.margin")
            HStack {
                Text("settings.tab.print.margin.top")
                TextField("\(INIT_TOP_MARGIN)", value: $imageTopMargin, formatter: NumberFormatter())
                    .frame(width: 80)
                    .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 10))
            }
            HStack {
                Text("settings.tab.print.margin.bottom")
                TextField("\(INIT_BOTTOM_MARGIN)", value: $imageBottomMargin, formatter: NumberFormatter())
                    .frame(width: 80)
                    .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 10))
            }
            HStack {
                Text("settings.tab.print.margin.left")
                TextField("\(INIT_LEFT_MARGIN)", value: $imageLeftMargin, formatter: NumberFormatter())
                    .frame(width: 80)
                    .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 10))
            }
            HStack {
                Text("settings.tab.print.margin.right")
                TextField("\(INIT_RIGHT_MARGIN)", value: $imageRightMargin, formatter: NumberFormatter())
                    .frame(width: 80)
                    .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 10))
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
