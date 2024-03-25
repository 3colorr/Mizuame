//
//  TabGeneral.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/25.
//

import SwiftUI
import ServiceManagement

struct TabGeneral: View {
    
    @EnvironmentObject var delegate: AppDelegate
    
    @AppStorage(SettingKeys.Menubar().keySavingMessage) private var isShowSavingMessage: Bool = SettingKeys.Menubar().initialSavingMessage

    @AppStorage(SettingKeys.StickyNote().keyPinNote) private var isPinNote: Bool = SettingKeys.StickyNote().initialPinNote

    @AppStorage(SettingKeys.StickyNote().keyLoginItems) private var isEnableLoginItems: Bool = SettingKeys.StickyNote().initialLoginItems

    @AppStorage(SettingKeys.StickyNote().keyShowFooter) private var isShowFooter: Bool = SettingKeys.StickyNote().initialShowFooter

    @AppStorage(SettingKeys.StickyNote().keyDragToResize) private var isDragToResize: Bool = SettingKeys.StickyNote().initialDragToResize

    @AppStorage(SettingKeys.StickyNote.NoteFontColor.Theme().key) private var isApplyThemeColorToFont: Bool = SettingKeys.StickyNote.NoteFontColor.Theme().initialVale

    @AppStorage(SettingKeys.StickyNote.NoteFontColor.Black().key) private var isApplyBlackColorToFont: Bool = SettingKeys.StickyNote.NoteFontColor.Black().initialVale

    @AppStorage(SettingKeys.StickyNote.NoteFontColor.DarkGray().key) private var isApplyDarkGrayColorToFont: Bool = SettingKeys.StickyNote.NoteFontColor.DarkGray().initialVale

    @AppStorage(SettingKeys.StickyNote.NoteFontColor.Gray().key) private var isApplyGrayColorToFont: Bool = SettingKeys.StickyNote.NoteFontColor.Gray().initialVale

    @AppStorage(SettingKeys.StickyNote().keyCalculateAction) private var isEnableCalculation: Bool = SettingKeys.StickyNote().initialCalculateAction
    
    @AppStorage(SettingKeys.StickyNote().keyPositionOfRoundsDecimalPoint) private var positionOfRoundsDecimalPoint: Int = SettingKeys.StickyNote().initialPositionOfRoundsDecimalPoint

    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 30) {
                HStack(alignment: .top) {
                    Text("settings.tab.general.note.title")
                        .frame(width: 100, alignment: .leading)

                    VStack(alignment: .leading) {
                        Toggle(isOn: $isShowFooter) {
                            Text("settings.tab.general.note.footer.visible")
                            Text("settings.tab.general.note.footer.visible.description")
                                .font(.subheadline)
                        }
                        .onChange(of: isShowFooter) { val in
                            //When the footer is hidden, footer items are disabled.
                            if val == false {
                                self.isDragToResize = false
                            }
                        }
                        
                        //These items are enabled only when the footer is visible.
                        VStack(alignment: .leading) {
                            Toggle(isOn: $isDragToResize) {
                                Text("settings.tab.general.note.footer.resize.note")
                            }
                            .disabled(!isShowFooter)
                        }
                        .padding(EdgeInsets(top: 5, leading: 20, bottom: 10, trailing: 0))

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

                        Toggle(isOn: $isEnableLoginItems) {
                            Text("settings.tab.general.note.note.loginitems")
                            Text("settings.tab.general.note.note.loginitems.description")
                                .font(.subheadline)
                        }
                        .onChange(of: isEnableLoginItems) { isEnable in
                            if isEnable {
                                do {
                                    try SMAppService.mainApp.register()
                                } catch {
                                    print(error.localizedDescription)
                                }
                            } else {
                                SMAppService.mainApp.unregister(completionHandler: { error in
                                    // if "err" is nil, the app is successfully unregistered from login items.
                                    if let err = error {
                                        print(err.localizedDescription)
                                    }
                                })
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
                            .fixedSize(horizontal: false, vertical: true)

                        VStack(alignment: .leading) {
                            Text("settings.tab.general.action.calculate.rounding")
                            
                            Picker("", selection: $positionOfRoundsDecimalPoint) {
                                ForEach(-1..<10, id: \.self) { p in
                                    if p < 0 {
                                        Text("settings.tab.general.action.calculate.rounding.digit.all")
                                    } else {
                                        Text("\(p)")
                                    }
                                }
                            }
                            .frame(width: 80)
                        }
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
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
                    self.isEnableCalculation = SettingKeys.StickyNote().initialCalculateAction
                    self.positionOfRoundsDecimalPoint = SettingKeys.StickyNote().initialPositionOfRoundsDecimalPoint
                }) {
                    Text("settings.tab.general.reset.button.caption")
                        .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
                }
            }
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
        }
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
