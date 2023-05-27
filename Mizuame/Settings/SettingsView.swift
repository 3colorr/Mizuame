//
//  PreferencesView.swift
//  Mizuame
//
//  Created by becomefoolish on 2023/05/11.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        TabView {
            TabGeneral()
                .tabItem {
                    Label("General", systemImage: "gearshape")
                }
            TabStickyNote()
                .tabItem {
                    Label("Sticky Note", systemImage: "macwindow")
                }
            TabHelp()
                .tabItem {
                    Label("Help", systemImage: "questionmark.circle")
                }
            TabInfo()
                .tabItem {
                    Label("Info", systemImage: "info.square")
                }
        }
        .frame(width: 400, height: 200)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
