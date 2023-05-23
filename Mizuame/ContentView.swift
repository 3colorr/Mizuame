//
//  ContentView.swift
//  Mizuame
//
//  Created by becomefoolish on 2023/05/07.
//

import SwiftUI

struct ContentView: View {
    // This app not work when enable fetch request. why??
    // But, it may not be a feature that this app need.
    //@FetchRequest(something)
    
    @State private var stickyText: String = "abc"
    
    @State private var isShowMessagebar: Bool = false
    @State private var userAction: MessagebarEnum = .NONE
    
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
        VStack {
            HStack {
                Image(systemName: "power")
                    .foregroundColor(Color.red)
                    .onTapGesture {
                        userAction = .QUIT
                        isShowMessagebar.toggle()
                    }
                
                Spacer()
                    .layoutPriority(1)
                
                Image(systemName: "eraser")
                    .onTapGesture {
                        userAction = .ALL_DELETE
                        isShowMessagebar.toggle()
                    }
            }
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5))
            
            if isShowMessagebar {
                MessagebarView(flag: $isShowMessagebar, selected: $userAction)
                    .onDisappear {
                        userActionDispatcher()
                    }
            }
            
            TextEditor(text: $stickyText)
                .layoutPriority(1)
            // FIX ME!!
            // onDisappear() not work
//                .onDisappear {
//                    print("onDisappear!! -> TextEditor")
//                    saveData()
//                }
        }
        .frame(width: 300, height: 150)
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

        default:
            // No action
            userAction = .NONE
        }
    }
    
    private func saveData() {
        let newContent = Content(markercolor: "000000", body: self.stickyText)
        let newData = StickyNote(tab: 1, contents: [newContent])
        
        _ = self.io.writeStickyNote(of: newData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
