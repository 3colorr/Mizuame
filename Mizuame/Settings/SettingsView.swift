//
//  PreferencesView.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/11.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var w: CGFloat = TabType.general.frameSize.width
    @State private var h: CGFloat = TabType.general.frameSize.height

    @State private var selectedTab: TabType = .general
    
    var body: some View {
        ZStack {
            if #available(macOS 14, *) {
                MainTabViewMacOS14orNewer()
            } else {
                MainTabView()
            }
        }
        .frame(width: w, height: h)
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
    }
    
    @available(macOS 14, *)
    private func MainTabViewMacOS14orNewer() -> some View {
        TabView(selection: $selectedTab) {
            TabGeneral()
                .tag(TabType.general)
                .tabItem {
                    Label(LocalizedStringKey("settings.tab.system.name.1"), systemImage: "gearshape")
                }
            TabStickyNote()
                .tag(TabType.note)
                .tabItem {
                    Label(LocalizedStringKey("settings.tab.system.name.2"), systemImage: "macwindow")
                }
            TabPrint()
                .tag(TabType.print)
                .tabItem{
                    Label(LocalizedStringKey("settings.tab.system.name.5"), systemImage: "printer")
                }
            TabHelp()
                .tag(TabType.help)
                .tabItem {
                    Label(LocalizedStringKey("settings.tab.system.name.3"), systemImage: "questionmark.circle")
                }
            TabInfo()
                .tag(TabType.info)
                .tabItem {
                    Label(LocalizedStringKey("settings.tab.system.name.4"), systemImage: "info.square")
                }
        }
        .onChange(of: selectedTab) {
            w = selectedTab.frameSize.width
            h = selectedTab.frameSize.height
        }
    }
    
    private func MainTabView() -> some View {
        TabView(selection: $selectedTab) {
            TabGeneral()
                .tag(TabType.general)
                .tabItem {
                    Label(LocalizedStringKey("settings.tab.system.name.1"), systemImage: "gearshape")
                }
            TabStickyNote()
                .tag(TabType.note)
                .tabItem {
                    Label(LocalizedStringKey("settings.tab.system.name.2"), systemImage: "macwindow")
                }
            TabPrint()
                .tag(TabType.print)
                .tabItem{
                    Label(LocalizedStringKey("settings.tab.system.name.5"), systemImage: "printer")
                }
            TabHelp()
                .tag(TabType.help)
                .tabItem {
                    Label(LocalizedStringKey("settings.tab.system.name.3"), systemImage: "questionmark.circle")
                }
            TabInfo()
                .tag(TabType.info)
                .tabItem {
                    Label(LocalizedStringKey("settings.tab.system.name.4"), systemImage: "info.square")
                }
        }
        .onChange(of: selectedTab) { selected in
            w = selected.frameSize.width
            h = selected.frameSize.height
        }
    }
}

extension SettingsView {
    enum TabType {
        case general
        case note
        case print
        case help
        case info
        
        var frameSize: (width: CGFloat, height: CGFloat) {
            switch self {
            case .general:
                return (450, 550)
            case .note:
                return (450, 500)
            case .print:
                return (450, 500)
            case .help:
                return (450, 500)
            case .info:
                return (450, 500)
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
