//
//  TabHelp.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/25.
//

import SwiftUI

struct TabHelp: View {

    @State private var showMarkdownSyntax: Bool = false


    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("settings.tab.help.greeting")
                        .bold()
                    
                    Text("settings.tab.help.introduce")
                    
                    Text("settings.tab.help.attention.title")
                        .bold()
                    
                    Text("settings.tab.help.attention.body")
                }

                VStack(alignment: .leading, spacing: 10) {
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
                        Image(systemName: "pin")
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                        Text("settings.tab.help.menu.pin.description")
                    }
                    
                    HStack {
                        Image(systemName: "eraser")
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                        Text("settings.tab.help.menu.eraser.description")
                    }
                    
                    HStack {
                        Image(systemName: "printer")
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                        Text("settings.tab.help.menu.printer.description")
                    }
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("settings.tab.help.note.title")
                        .bold()

                    Text("settings.tab.help.note.greeting")

                    HStack {
                        Image(systemName: "function")
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                            .bold()
                        
                        Text("settings.tab.help.note.action.calculate.description")
                    }

                    HStack {
                        Image(systemName: "m.square")
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                            .imageScale(.large)
                            .bold()

                        
                        VStack(alignment: .leading)  {
                            Text("settings.tab.help.note.action.markdown.description")
                            
                            Button(showMarkdownSyntax ? "settings.tab.help.note.action.markdown.syntax.close" : "settings.tab.help.note.action.markdown.syntax.open") {
                                showMarkdownSyntax.toggle()
                            }
                        }
                    }
                    
                    if showMarkdownSyntax {
                        SupportMarkdownSyntax()
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    }
                }

                Spacer()
            }
        }
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
