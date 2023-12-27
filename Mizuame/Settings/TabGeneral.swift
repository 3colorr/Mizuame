//
//  TabGeneral.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/25.
//

import SwiftUI
import StoreKit

struct TabGeneral: View {
    
    @EnvironmentObject var delegate: AppDelegate
    
    @AppStorage(SettingKeys.Menubar().keySavingMessage) private var isShowSavingMessage: Bool = SettingKeys.Menubar().initialSavingMessage

    @AppStorage(SettingKeys.StickyNote().keyPinNote) private var isPinNote: Bool = SettingKeys.StickyNote().initialPinNote

    @AppStorage(SettingKeys.StickyNote.NoteFontColor.Theme().key) private var isApplyThemeColorToFont: Bool = SettingKeys.StickyNote.NoteFontColor.Theme().initialVale

    @AppStorage(SettingKeys.StickyNote.NoteFontColor.Black().key) private var isApplyBlackColorToFont: Bool = SettingKeys.StickyNote.NoteFontColor.Black().initialVale

    @AppStorage(SettingKeys.StickyNote.NoteFontColor.DarkGray().key) private var isApplyDarkGrayColorToFont: Bool = SettingKeys.StickyNote.NoteFontColor.DarkGray().initialVale

    @AppStorage(SettingKeys.StickyNote.NoteFontColor.Gray().key) private var isApplyGrayColorToFont: Bool = SettingKeys.StickyNote.NoteFontColor.Gray().initialVale

    @AppStorage(SettingKeys.StickyNote().keyCalculateAction) private var isEnableCalculation: Bool = SettingKeys.StickyNote().initialCalculateAction

    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 30) {
                HStack(alignment: .top) {
                    Text("settings.tab.general.note.title")
                        .frame(width: 100, alignment: .leading)

                    VStack(alignment: .leading) {
                        Toggle(isOn: $isShowSavingMessage) {
                            Text("settings.tab.general.note.menubar.saving")
                        }
                        
                        Toggle(isOn: $isPinNote) {
                            Text("settings.tab.general.note.note.pin")
                        }
                        .onChange(of: isPinNote) { isPinning in
                            if isPinning {
                                delegate.enablePinning()
                            } else {
                                delegate.disablePinning()
                            }
                        }
                    }
                }

                HStack(alignment: .top) {
                    Text("settings.tab.general.font.color.title")
                        .frame(width: 100, alignment: .leading)

                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Button(action: {
                                isApplyThemeColorToFont = true
                                isApplyBlackColorToFont = false
                                isApplyDarkGrayColorToFont = false
                                isApplyGrayColorToFont = false
                            }, label: {
                                if isApplyThemeColorToFont {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.blue)
                                        .bold()
                                } else {
                                    Image(systemName: "circle")
                                }
                                
                                Text("settings.tab.general.font.color.choice.theme")
                            })
                            .buttonStyle(.plain)
                        }

                        HStack {
                            Button(action: {
                                isApplyThemeColorToFont = false
                                isApplyBlackColorToFont = true
                                isApplyDarkGrayColorToFont = false
                                isApplyGrayColorToFont = false
                            }, label: {
                                if isApplyBlackColorToFont {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.blue)
                                        .bold()
                                } else {
                                    Image(systemName: "circle")
                                }
                                
                                Text("settings.tab.general.font.color.choice.black")
                            })
                            .buttonStyle(.plain)
                        }

                        HStack {
                            Button(action: {
                                isApplyThemeColorToFont = false
                                isApplyBlackColorToFont = false
                                isApplyDarkGrayColorToFont = true
                                isApplyGrayColorToFont = false
                            }, label: {
                                if isApplyDarkGrayColorToFont {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.blue)
                                        .bold()
                                } else {
                                    Image(systemName: "circle")
                                }
                                
                                Text("settings.tab.general.font.color.choice.darkgray")
                            })
                            .buttonStyle(.plain)
                        }

                        HStack {
                            Button(action: {
                                isApplyThemeColorToFont = false
                                isApplyBlackColorToFont = false
                                isApplyDarkGrayColorToFont = false
                                isApplyGrayColorToFont = true
                            }, label: {
                                if isApplyGrayColorToFont {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.blue)
                                        .bold()
                                } else {
                                    Image(systemName: "circle")
                                }
                                
                                Text("settings.tab.general.font.color.choice.gray")
                            })
                            .buttonStyle(.plain)
                        }
                    }
                }

                HStack(alignment: .top) {
                    Text("settings.tab.general.action.title")
                        .frame(width: 100, alignment: .leading)

                    VStack(alignment: .leading) {
                        Toggle(isOn: $isEnableCalculation) {
                            Text("settings.tab.general.action.calculate")
                        }
                        
                        Text("settings.tab.help.note.action.calculate.description")
                            .font(.subheadline)
                    }
                }
            }
            
            Spacer()
            
            HStack {
                Text("settings.tab.general.reset.title")
                    .frame(width: 100, alignment: .leading)

                Button(action: {
                    self.isShowSavingMessage = SettingKeys.Menubar().initialSavingMessage
                    self.isPinNote = SettingKeys.StickyNote().initialPinNote
                    self.isApplyThemeColorToFont = SettingKeys.StickyNote.NoteFontColor.Theme().initialVale
                    self.isApplyBlackColorToFont = SettingKeys.StickyNote.NoteFontColor.Black().initialVale
                    self.isApplyDarkGrayColorToFont = SettingKeys.StickyNote.NoteFontColor.DarkGray().initialVale
                    self.isApplyGrayColorToFont = SettingKeys.StickyNote.NoteFontColor.Gray().initialVale
                }) {
                    Text("settings.tab.general.reset.button.caption")
                        .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
                }
            }
        }
        .frame(width: 450, height: 350)
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
    }
}

struct TabStickyNote_Previews: PreviewProvider {
    static var previews: some View {
        let localizations = ["en", "ja"]
        ForEach(localizations, id: \.self) { lang in
            TabGeneral()
                .previewDisplayName("lcal:\(lang)")
                .environment(\.locale, .init(identifier: lang))
        }
    }
}
