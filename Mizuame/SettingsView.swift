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
                Text("Hello General")
            }
            .padding(5)
            .tabItem {
                Label("General", systemImage: "gearshape")
            }
            Form {
                Text("Hello window")
            }
            .padding(5)
            .tabItem {
                Label("Windows", systemImage: "macwindow")
            }
            Form {
                Text("Hello Help")
            }
            .padding(5)
            .tabItem {
                Label("Help", systemImage: "questionmark.circle")
            }
            Form {
                Text("Hello Info")
            }
            .padding(5)
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
