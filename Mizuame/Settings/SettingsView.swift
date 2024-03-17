//
//  PreferencesView.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/11.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var w: CGFloat = 400
    @State private var h: CGFloat = 350

    @State private var selectedTab: TabType = .general
    
    var body: some View {
        ZStack {
            Color("SettingsBackground")
            
            if #available(macOS 14, *) {
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
        }
        .frame(width: w, height: h)
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
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
                return (400, 350)
            case .note:
                return (400, 500)
            case .print:
                return (400, 500)
            case .help:
                return (400, 500)
            case .info:
                return (400, 500)
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
