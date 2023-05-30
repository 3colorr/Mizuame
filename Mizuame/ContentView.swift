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
    
    @AppStorage(SettingKeys.StickyNote().keyWidth) private var width: Int = SettingKeys.StickyNote().initialWidth
    @AppStorage(SettingKeys.StickyNote().keyHeight) private var height: Int = SettingKeys.StickyNote().initialHeight
    @AppStorage(SettingKeys.FontSize().key) private var fontSize: Int = SettingKeys.FontSize().initialValue

    @AppStorage(SettingKeys.UserConfirm().keyAgreement) private var viewState: Int = SettingKeys.UserConfirm().initialViewState

    @State private var stickyText: String = "abc"
    
    @State private var isShowMessagebar: Bool = false
    @State private var userAction: MessagebarEnum = .NONE
    
    @State private var isExecutableSave: Bool = true
    
    private let delegate = AppDelegate()
    
    private let io: DataIO
    private var data: StickyNote
    
    init() {
        self.io = DataIO()
        
        if let data = self.io.readStickyNote() {
            self.data = data
        } else {
            self.data = StickyNote(tab: 1, contents: [Content(markercolor: "000000", body: "")])
        }
        
        _stickyText = State(initialValue: self.data.contents[0].body)
    }
    
    var body: some View {
        switch viewState {
        case SettingsViewState.TERMS_OF_SERVICE.rawValue:
            TermsOfServiceView(state: $viewState)
            
        case SettingsViewState.PRIVACY_POLICY.rawValue:
            PrivacyPolicyView(state: $viewState)
            
        default:
            VStack {
                HStack {
                    Image(systemName: "power")
                        .foregroundColor(Color.red)
                        .onTapGesture {
                            userAction = .QUIT
                            isShowMessagebar = true
                        }
                    
                    Spacer()
                        .layoutPriority(1)
                    
                    Image(systemName: "eraser")
                        .onTapGesture {
                            userAction = .ALL_DELETE
                            isShowMessagebar = true
                        }
                    
                    Image(systemName: "gearshape.fill")
                        .onTapGesture {
                            delegate.showSettings()
                        }
                }
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5))
                
                if isShowMessagebar {
                    MessagebarView(flag: $isShowMessagebar, selected: $userAction, fontSize: self.fontSize)
                        .onDisappear {
                            userActionDispatcher()
                        }
                }
                
                TextEditor(text: $stickyText)
                    .layoutPriority(1)
                    .font(.system(size: CGFloat(self.fontSize)))
                    .onChange(of: stickyText) { val in
                        if isExecutableSave {
                            Task {
                                do {
                                    isExecutableSave = false
                                    try await Task.sleep(nanoseconds: 3 * 1000000000)
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
            .frame(width: CGFloat(self.width), height: CGFloat(self.height))
        }
    }
    
    private func userActionDispatcher() {
        switch userAction {
        case .QUIT:
            self.userAction = .NONE
            saveData()
            NSApplication.shared.terminate(self)

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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
