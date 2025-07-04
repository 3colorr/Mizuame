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
                        Spacer()
                        Text("\u{2318},")
                    }
                    .frame(width: 250)
                    
                    HStack {
                        Image(systemName: "pin")
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                        Text("settings.tab.help.menu.pin.description")
                        Spacer()
                        Text("\u{2318}\u{2325}P")
                    }
                    .frame(width: 250)
                    
                    HStack {
                        Image(systemName: "eraser")
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                        Text("settings.tab.help.menu.eraser.description")
                    }
                    
                    HStack {
                        Image(systemName: "ellipsis.circle")
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                        Text("settings.tab.help.menu.others.description")
                    }
                    
                    HStack {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 1)
                            .foregroundColor(.gray)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Image(systemName: "printer")
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                                Text("settings.tab.help.menu.others.list.printer.description")
                            }
                            
                            if #available(macOS 15, *) {
                                HStack {
                                    Image(systemName: "arrow.up.document")
                                        .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 10))
                                    Text("settings.tab.help.menu.others.list.export.description")
                                }

                                HStack {
                                    Image(systemName: "arrow.down.document")
                                        .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 10))
                                    Text("settings.tab.help.menu.others.list.import.description")
                                }

                            } else {
                                HStack {
                                    Image(systemName: "square.and.arrow.up")
                                        .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 10))
                                    Text("settings.tab.help.menu.others.list.export.description")
                                }

                                HStack {
                                    Image(systemName: "square.and.arrow.down")
                                        .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 10))
                                    Text("settings.tab.help.menu.others.list.import.description")
                                }
                            }
                        }
                        .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                    }
                    .padding(.leading, 35)
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("settings.tab.help.note.title")
                        .bold()

                    Text("settings.tab.help.note.greeting")

                    HStack(alignment: .top) {
                        Image(systemName: "function")
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                            .bold()
                        
                        Text("settings.tab.help.note.action.calculate.description")
                    }

                    HStack(alignment: .top) {
                        Image(systemName: "m.square")
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                            .imageScale(.large)
                            .bold()

                        
                        VStack(alignment: .leading, spacing: 10)  {
                            Text("settings.tab.help.note.action.markdown.description")

                            VStack(alignment: .leading, spacing: 5) {
                                Text("settings.tab.help.note.action.markdown.description.menu")
                                    .bold()

                                HStack(alignment: .top) {
                                    Image(systemName: "square.and.pencil")
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                                    Text("settings.tab.help.note.action.markdown.description.menu.edit")
                                        .fixedSize(horizontal: false, vertical: true)
                                }

                                HStack {
                                    Image(systemName: "m.square")
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                                        .bold()
                                    Text("settings.tab.help.note.action.markdown.description.menu.preview")
                                }
                            }

                            Button(showMarkdownSyntax ? "settings.tab.help.note.action.markdown.syntax.close" : "settings.tab.help.note.action.markdown.syntax.open") {
                                showMarkdownSyntax.toggle()
                            }
                        }
                    }
                    
                    if showMarkdownSyntax {
                        SupportMarkdownSyntax()
                            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 0))
                    }
                }

                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
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
