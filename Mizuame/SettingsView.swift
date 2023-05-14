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
            Form {
                Text("Hello pref")
            }
            .padding(5)
            .tabItem {
                Label("Settings", systemImage: "slider.horizontal.3")
            }
        }
        .frame(width: 300, height: .none)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
