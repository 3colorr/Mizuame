//
//  ContentView.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/07.
//

import SwiftUI

struct ContentView: View {
    // This app not work when enable fetch request. why??
    // But, it may not be a feature that this app need.
    //@FetchRequest(something)
    
    let delegate: AppDelegate

    @ObservedObject var printer = PrinterModel()

    @AppStorage(SettingKeys.StickyNote().keyPinNote) private var isPinNote: Bool = SettingKeys.StickyNote().initialPinNote

    @AppStorage(SettingKeys.Menubar().keySavingMessage) private var isShowSavingMessage: Bool = SettingKeys.Menubar().initialSavingMessage

    @AppStorage(SettingKeys.StickyNote().keyWidth) private var width: Int = SettingKeys.StickyNote().initialWidth
    @AppStorage(SettingKeys.StickyNote().keyHeight) private var height: Int = SettingKeys.StickyNote().initialHeight
    
    @AppStorage(SettingKeys.FontSize().key) private var fontSize: Int = SettingKeys.FontSize().initialValue
    @AppStorage(SettingKeys.StickyNote().keyLineSpacing) private var lineSpacing: Int = SettingKeys.StickyNote().initialLineSpacing

    @AppStorage(SettingKeys.StickyNoteColor().keyForeground) private var bodyForegroundTheme: String = SettingKeys.StickyNoteColor().initialForegroundTheme
    @AppStorage(SettingKeys.StickyNoteColor().keyBackground) private var bodyBackgroundTheme: String = SettingKeys.StickyNoteColor().initialBackgroundTheme

    @AppStorage(SettingKeys.FrameColor().keyTheme) private var frameTheme: String = SettingKeys.FrameColor().initialTheme

    @AppStorage(SettingKeys.UserConfirm().keyAgreement) private var viewState: Int = SettingKeys.UserConfirm().initialViewState

    @State private var stickyText: String = "abc"
    
    @State private var isShowMessagebar: Bool = false
    @State private var userAction: MessagebarEnum = .NONE
    
    @State private var isExecutableSave: Bool = true

    private let io: DataIO
    private var data: StickyNote
    
    private let redoUndoManager: RedoUndo
    
    init(delegate: AppDelegate) {
        self.delegate = delegate
        self.io = DataIO()
        
        if let data = self.io.readStickyNote() {
            self.data = data
        } else {
            self.data = StickyNote(tab: 1, contents: [Content(markercolor: "000000", body: "")])
        }
        
        _stickyText = State(initialValue: self.data.contents[0].body)
        
        redoUndoManager = RedoUndo(initialNote: self.data.contents[0].body)
    }
    
    var body: some View {
        switch viewState {
        case SettingsViewState.TERMS_OF_SERVICE.rawValue:
            TermsOfServiceView(state: $viewState)
            
        case SettingsViewState.PRIVACY_POLICY.rawValue:
            PrivacyPolicyView(state: $viewState)
            
        default:
            ZStack {
                Color(frameTheme)
                
                VStack(spacing: 0) {
                    HStack {
                        Image(systemName: "power")
                            .foregroundColor(Color.red)
                            .onTapGesture {
                                userAction = .QUIT
                                isShowMessagebar.toggle()
                                
                                if !isShowMessagebar {
                                    userAction = .NONE
                                }
                            }
                        
                        if isShowSavingMessage && !isExecutableSave {
                            Text("sitickynote.menu.message.saving")
                                .padding(.horizontal, 5)
                                .layoutPriority(2)
                        }
                        
                        Spacer()
                            .layoutPriority(1)
                        
                        Button(action: {
                            stickyText = redoUndoManager.undo()
                        }, label: {
                            Image(systemName: "return.left")
                        })
                        .hidden()
                        .keyboardShortcut("z", modifiers: [.command])
                        
                        Button(action: {
                            stickyText = redoUndoManager.redo()
                        }, label: {
                            Image(systemName: "return.right")
                        })
                        .hidden()
                        .keyboardShortcut("y", modifiers: [.command])

                        if isPinNote {
                            Image(systemName: "pin")
                                .foregroundColor(Color.red)
                                .onTapGesture {
                                    togglePinningNote()
                                }
                        } else {
                            Image(systemName: "pin.slash")
                                .foregroundColor(Color(bodyForegroundTheme))
                                .onTapGesture {
                                    togglePinningNote()
                                }
                        }

                        Image(systemName: "eraser")
                            .foregroundColor(Color(bodyForegroundTheme))
                            .onTapGesture {
                                userAction = .ALL_DELETE
                                isShowMessagebar.toggle()
                                
                                if !isShowMessagebar {
                                    userAction = .NONE
                                }
                            }

                        Image(systemName: "printer")
                            .foregroundColor(Color(bodyForegroundTheme))
                            .onTapGesture {
                                isShowMessagebar = false
                                userAction = .NONE
                                
                                printer.textFontSize = self.fontSize
                                printer.textColor = self.bodyForegroundTheme
                                printer.printSize = NSRect(x: 0, y: 0, width: self.width, height: self.height)
                                printer.doPrinting(content: stickyText)
                            }

                        if #available(macOS 14, *) {
                            SettingsLink {
                                Image(systemName: "gearshape.fill")
                                    .foregroundColor(Color(bodyForegroundTheme))
                            }
                            .buttonStyle(SettingsLinkStyle())
                            .keyboardShortcut(",", modifiers: [.command])
                            .onHover { _ in
                                isShowMessagebar = false
                                userAction = .NONE
                            }
                            // Not work.
                            // .onTapGesture {}

                        } else {
                            Button(action: {
                                isShowMessagebar = false
                                userAction = .NONE
                                delegate.showSettings()
                            }, label: {
                                Image(systemName: "gearshape.fill")
                                    .foregroundColor(Color(bodyForegroundTheme))
                            })
                            .buttonStyle(SettingsLinkStyle())
                            .keyboardShortcut(",", modifiers: [.command])
                        }
                    }
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    
                    if isShowMessagebar {
                        MessagebarView(flag: $isShowMessagebar, selected: $userAction)
                            .onDisappear {
                                userActionDispatcher()
                            }
                    }
                    
                    TextEditor(text: $stickyText)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .layoutPriority(1)
                        .font(.system(size: CGFloat(self.fontSize)))
                        .lineSpacing(CGFloat(self.lineSpacing))
                        .foregroundColor(Color(bodyForegroundTheme))
                        .scrollContentBackground(.hidden)
                        .background(Color(bodyBackgroundTheme))
                        .onChange(of: stickyText) { val in
                            
                            _ = redoUndoManager.snapshot(of: val)
                            
                            let calculater = CalculateModel()
                            let parser = NoteParser()
                            for formulaRange in parser.parse(note: val) {
                                if let result = calculater.result(formula: String(val[formulaRange])) {
                                    
                                    // A splitedIndex is index of formula end.
                                    // If the note is "abc(1+2=)efg", the splitedIndex is between ")" and "e".
                                    let splitIndex = val.index(formulaRange.upperBound, offsetBy: 2)

                                    // If there is a calculation result, replace a old calculation result with a new one.
                                    // If there is no a calculation result, insert a calculation result into the note.
                                    if let resultRangeInNote = parser.parseResultRange(note: val, formulaRange: formulaRange) {

                                        if "\(result)" != val[resultRangeInNote] {
                                            // Insert the new result into the note.
                                            stickyText = "\(String(val[val.startIndex..<splitIndex])) \(result) \(String(val[resultRangeInNote.upperBound..<val.endIndex]))"
                                        }
                                        
                                    } else {
                                        // Insert the result into the note.
                                        stickyText = "\(String(val[val.startIndex..<splitIndex])) \(result) \(String(val[splitIndex..<val.endIndex]))"
                                    }
                                    
                                    // *Information
                                    //
                                    // SwiftUI TextEditor doesn't support AttributedStrings.
                                    // So, Cannot change background color of formula part in the note.
                                    //
                                    // var attributedVal = AttributedString(val)
                                    // if let applyRange = attributedVal.range(of: String(val[formulaRange])) {
                                    //     attributedVal[applyRange].backgroundColor = .gray
                                    // }
                                }
                            }
                            
                            if isExecutableSave {
                                Task {
                                    do {
                                        isExecutableSave = false
                                        try await Task.sleep(nanoseconds: 15 * 100000000)
                                        saveData()
                                        
                                    } catch {
                                        print("Fatal error: Failed to save JSON data.")
                                        userAction = .DO_NOT_SAVE_JSON
                                        isShowMessagebar = true
                                    }
                                }
                            }
                        }
                }
            }
            .frame(width: CGFloat(self.width), height: CGFloat(self.height))
        }
    }
    
    private func userActionDispatcher() {
        switch userAction {
        case .QUIT:
            self.userAction = .NONE
            saveData()
            delegate.quitApp()

        case .ALL_DELETE:
            self.userAction = .NONE
            self.stickyText = ""
            
        case .DO_NOT_SAVE_JSON:
            self.userAction = .NONE
            saveData()

        default:
            // No action
            userAction = .NONE
        }
    }
    
    private func saveData() {
        let newContent = Content(markercolor: "000000", body: self.stickyText)
        let newData = StickyNote(tab: 1, contents: [newContent])
        
        _ = self.io.writeStickyNote(of: newData)
        
        isExecutableSave = true
    }
    
    private func togglePinningNote() {
        isPinNote.toggle()
        
        if isPinNote {
            delegate.enablePinning()
        } else {
            delegate.disablePinning()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(delegate: AppDelegate())
    }
}
