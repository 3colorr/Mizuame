//
//  TabHelp.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/25.
//

import SwiftUI

struct TabHelp: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("settings.tab.help.greeting")
                    .bold()

                Text("settings.tab.help.introduce")

                Text("settings.tab.help.attention.title")
                    .bold()

                Text("settings.tab.help.attention.body")
                
                Text("settings.tab.help.menu.title")
                    .bold()
                
                HStack {
                    Image(systemName: "power")
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                    Text("settings.tab.help.menu.power.description")
                }

                HStack {
                    Image(systemName: "gearshape.fill")
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                    Text("settings.tab.help.menu.preference.description")
                }

                HStack {
                    Image(systemName: "eraser")
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                    Text("settings.tab.help.menu.eraser.description")
                }
                
                Spacer()
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        }
        .frame(width: 400, height: 300)
    }
}

struct TabHelp_Previews: PreviewProvider {
    static var previews: some View {
        let localizations = ["en", "ja"]
        ForEach(localizations, id: \.self) { lang in
            TabHelp()
                .previewDisplayName("lcal:\(lang)")
                .environment(\.locale, .init(identifier: lang))
        }
    }
}
