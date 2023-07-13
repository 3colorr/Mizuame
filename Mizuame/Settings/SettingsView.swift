//
//  PreferencesView.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/11.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        ZStack {
            Color("SettingsBackground")
            
            TabView {
                TabGeneral()
                    .tabItem {
                        Label(LocalizedStringKey("settings.tab.system.name.1"), systemImage: "gearshape")
                    }
                TabStickyNote()
                    .tabItem {
                        Label(LocalizedStringKey("settings.tab.system.name.2"), systemImage: "macwindow")
                    }
                TabPrint()
                    .tabItem{
                        Label(LocalizedStringKey("settings.tab.system.name.5"), systemImage: "printer")
                    }
                TabHelp()
                    .tabItem {
                        Label(LocalizedStringKey("settings.tab.system.name.3"), systemImage: "questionmark.circle")
                    }
                TabInfo()
                    .tabItem {
                        Label(LocalizedStringKey("settings.tab.system.name.4"), systemImage: "info.square")
                    }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let localizations = ["en", "ja"]
        ForEach(localizations, id: \.self) { lang in
            SettingsView()
                .previewDisplayName("lcal:\(lang)")
                .environment(\.locale, .init(identifier: lang))
        }
    }
}
