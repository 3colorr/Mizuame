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

    @AppStorage(SettingKeys.StickyNote().keyAutomaticallyHideHeader) private var isAutomaticallyHideHeader: Bool = SettingKeys.StickyNote().initialAutomaticallyHideHeader

    @AppStorage(SettingKeys.StickyNote.NoteFontColor.Theme().key) private var isApplyThemeColorToFont: Bool = SettingKeys.StickyNote.NoteFontColor.Theme().initialVale

    @AppStorage(SettingKeys.StickyNote.NoteFontColor.Black().key) private var isApplyBlackColorToFont: Bool = SettingKeys.StickyNote.NoteFontColor.Black().initialVale

    @AppStorage(SettingKeys.StickyNote.NoteFontColor.DarkGray().key) private var isApplyDarkGrayColorToFont: Bool = SettingKeys.StickyNote.NoteFontColor.DarkGray().initialVale

    @AppStorage(SettingKeys.StickyNote.NoteFontColor.Gray().key) private var isApplyGrayColorToFont: Bool = SettingKeys.StickyNote.NoteFontColor.Gray().initialVale

    @AppStorage(SettingKeys.StickyNote().keyCalculateAction) private var isEnableCalculation: Bool = SettingKeys.StickyNote().initialCalculateAction
    
    @AppStorage(SettingKeys.StickyNote().keyPositionOfRoundsDecimalPoint) private var positionOfRoundsDecimalPoint: Int = SettingKeys.StickyNote().initialPositionOfRoundsDecimalPoint

    @AppStorage(SettingKeys.StickyNote().keyMarkdownAction) private var isEnableMarkdown: Bool = SettingKeys.StickyNote().initialMarkdownAction
    @AppStorage(SettingKeys.StickyNote().keyShowMarkdownPreview) private var showMarkdownPreview: Bool = SettingKeys.StickyNote().initialShowMarkdownPreview

    @AppStorage(SettingKeys.StickyNote.KeyboardShortcuts().keyKeyboardShortcutAction) private var keyboardShortcutPattern: Int = SettingKeys.StickyNote.KeyboardShortcuts.KeyboardPattern().none

    @State private var isEnableLoginItems: Bool = false
    
    
    var body: some View {
        ScrollView {
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
                            .onAppear {
                                isEnableLoginItems = (SMAppService.mainApp.status == .enabled)
                            }
                            
                            Toggle(isOn: $isAutomaticallyHideHeader) {
                                Text("settings.tab.general.note.menubar.automatically.hide")
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
                        Text("settings.tab.general.note.note.keyboardshortcut")
                            .frame(width: 100, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("settings.tab.general.note.note.keyboardshortcut.title")
                                .fixedSize(horizontal: false, vertical: true)

                            Text("settings.tab.general.note.note.keyboardshortcut.description")
                                .font(.subheadline)
                                .fixedSize(horizontal: false, vertical: true)

                            VStack(alignment: .leading) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                Text("settings.tab.general.note.note.keyboardshortcut.warning")
                                    .font(.subheadline)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(5)
                            .background(Color("SettingsAccentColor"), in: RoundedRectangle(cornerRadius: 5))

                            if #available(macOS 14, *) {
                                Picker("", selection: $keyboardShortcutPattern) {
                                    Text("settings.tab.general.note.note.keyboardshortcut.choice.disable").tag(SettingKeys.StickyNote.KeyboardShortcuts.KeyboardPattern().none)
                                    Text("settings.tab.general.note.note.keyboardshortcut.choice.command.left").tag(SettingKeys.StickyNote.KeyboardShortcuts.KeyboardPattern().leftCommand)
                                    Text("settings.tab.general.note.note.keyboardshortcut.choice.command.right").tag(SettingKeys.StickyNote.KeyboardShortcuts.KeyboardPattern().rightCommand)
                                    Text("settings.tab.general.note.note.keyboardshortcut.choice.control").tag(SettingKeys.StickyNote.KeyboardShortcuts.KeyboardPattern().control)
                                    Text("settings.tab.general.note.note.keyboardshortcut.choice.option").tag(SettingKeys.StickyNote.KeyboardShortcuts.KeyboardPattern().option)
                                }
                                .frame(width: 180)
                                .onChange(of: keyboardShortcutPattern) {
                                    checkAccessibilityPermission()
                                }

                            } else {
                                Picker("", selection: $keyboardShortcutPattern) {
                                    Text("settings.tab.general.note.note.keyboardshortcut.choice.disable").tag(SettingKeys.StickyNote.KeyboardShortcuts.KeyboardPattern().none)
                                    Text("settings.tab.general.note.note.keyboardshortcut.choice.command.left").tag(SettingKeys.StickyNote.KeyboardShortcuts.KeyboardPattern().leftCommand)
                                    Text("settings.tab.general.note.note.keyboardshortcut.choice.command.right").tag(SettingKeys.StickyNote.KeyboardShortcuts.KeyboardPattern().rightCommand)
                                    Text("settings.tab.general.note.note.keyboardshortcut.choice.control").tag(SettingKeys.StickyNote.KeyboardShortcuts.KeyboardPattern().control)
                                    Text("settings.tab.general.note.note.keyboardshortcut.choice.option").tag(SettingKeys.StickyNote.KeyboardShortcuts.KeyboardPattern().option)
                                }
                                .frame(width: 180)
                                .onChange(of: keyboardShortcutPattern) { selectedPattern in
                                    checkAccessibilityPermission()
                                }
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
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 0))
                            
                            Toggle(isOn: $isEnableMarkdown) {
                                Text("settings.tab.general.action.markdown")
                            }
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                            .onChange(of: isEnableMarkdown) { newValue in
                                
                                // ** Why do we change "showMarkdownPreview" to FALSE                         **
                                // ** when the user disables "Markdown preview (turns off isEnableMarkdown)"? **
                                // When the user enables "Markdown preview (turn on 'isEnableMarkdown')",
                                // "showMarkdownPreview" will be TRUE every time the user opens a note to the Markdown preview.
                                // By setting "showMarkdownPreview" to FALSE, the note's menu will be displayed correctly.
                                
                                if !newValue {
                                    showMarkdownPreview = false
                                }
                            }
                            
                            Text("settings.tab.help.note.action.markdown.description")
                                .font(.subheadline)
                                .fixedSize(horizontal: false, vertical: true)
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
                        self.isAutomaticallyHideHeader = SettingKeys.StickyNote().initialAutomaticallyHideHeader
                        self.isEnableMarkdown = SettingKeys.StickyNote().initialMarkdownAction
                        self.showMarkdownPreview = SettingKeys.StickyNote().initialShowMarkdownPreview
                        self.keyboardShortcutPattern = SettingKeys.StickyNote.KeyboardShortcuts.KeyboardPattern().none
                    }) {
                        Text("settings.tab.general.reset.button.caption")
                            .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
        }
    }

    private func checkAccessibilityPermission() {
        if keyboardShortcutPattern != SettingKeys.StickyNote.KeyboardShortcuts.KeyboardPattern().none {
            if AXIsProcessTrusted() == false {
                let alert = NSAlert()
                alert.messageText = NSLocalizedString("settings.tab.general.note.note.keyboardshortcut.alert.title", comment: "")
                alert.informativeText = NSLocalizedString("settings.tab.general.note.note.keyboardshortcut.description", comment: "") + "\n\n" + NSLocalizedString("settings.tab.general.note.note.keyboardshortcut.warning", comment: "")
                alert.addButton(withTitle: "OK")
                alert.runModal()
            }
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
