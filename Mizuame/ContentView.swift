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

    @AppStorage(SettingKeys.StickyNote().keyAutomaticallyHideHeader) private var isAutomaticallyHideHeader: Bool = SettingKeys.StickyNote().initialAutomaticallyHideHeader

    @AppStorage(SettingKeys.Menubar().keySavingMessage) private var isShowSavingMessage: Bool = SettingKeys.Menubar().initialSavingMessage
    
    @AppStorage(SettingKeys.StickyNote().keyCalculateAction) private var isEnableCalculation: Bool = SettingKeys.StickyNote().initialCalculateAction

    @AppStorage(SettingKeys.StickyNote().keyMarkdownAction) private var isEnableMarkdown: Bool = SettingKeys.StickyNote().initialMarkdownAction
    @AppStorage(SettingKeys.StickyNote().keyShowMarkdownPreview) private var showMarkdownPreview: Bool = SettingKeys.StickyNote().initialShowMarkdownPreview

    @AppStorage(SettingKeys.StickyNote().keyPositionOfRoundsDecimalPoint) private var positionOfRoundsDecimalPoint: Int = SettingKeys.StickyNote().initialPositionOfRoundsDecimalPoint

    @AppStorage(SettingKeys.StickyNote().keyWidth) private var width: Int = SettingKeys.StickyNote().initialWidth
    @AppStorage(SettingKeys.StickyNote().keyHeight) private var height: Int = SettingKeys.StickyNote().initialHeight
    
    @AppStorage(SettingKeys.FontSize().key) private var fontSize: Int = SettingKeys.FontSize().initialValue
    @AppStorage(SettingKeys.StickyNote().keyLineSpacing) private var lineSpacing: Int = SettingKeys.StickyNote().initialLineSpacing

    @AppStorage(SettingKeys.StickyNoteColor().keyForeground) private var bodyForegroundTheme: String = SettingKeys.StickyNoteColor().initialForegroundTheme
    @AppStorage(SettingKeys.StickyNoteColor().keyBackground) private var bodyBackgroundTheme: String = SettingKeys.StickyNoteColor().initialBackgroundTheme

    @AppStorage(SettingKeys.MarkdownViewColor().keyCodeBlock) private var markdownCodeBlockTheme: String = SettingKeys.MarkdownViewColor().initialCodeBlockTheme
    @AppStorage(SettingKeys.MarkdownViewColor().keyFormulaBlock) private var markdownFormulaBlockTheme: String = SettingKeys.MarkdownViewColor().initialFormulaBlockTheme

    @AppStorage(SettingKeys.StickyNote.NoteFontColor.Theme().key) private var isApplyThemeColorToFont: Bool = SettingKeys.StickyNote.NoteFontColor.Theme().initialVale

    @AppStorage(SettingKeys.StickyNote.NoteFontColor.Black().key) private var isApplyBlackColorToFont: Bool = SettingKeys.StickyNote.NoteFontColor.Black().initialVale

    @AppStorage(SettingKeys.StickyNote.NoteFontColor.DarkGray().key) private var isApplyDarkGrayColorToFont: Bool = SettingKeys.StickyNote.NoteFontColor.DarkGray().initialVale

    @AppStorage(SettingKeys.StickyNote.NoteFontColor.Gray().key) private var isApplyGrayColorToFont: Bool = SettingKeys.StickyNote.NoteFontColor.Gray().initialVale

    @AppStorage(SettingKeys.FrameColor().keyTheme) private var frameTheme: String = SettingKeys.FrameColor().initialTheme

    @AppStorage(SettingKeys.UserConfirm().keyAgreement) private var viewState: Int = SettingKeys.UserConfirm().initialViewState

    @State private var stickyText: String = "abc"
    
    @State private var isShowMessagebar: Bool = false
    @State private var userAction: MessagebarEnum = .NONE
    
    @State private var isExecutableSave: Bool = true
    
    @State private var isDraggableVertical: Bool = false
    @State private var isDraggableHorizontal: Bool = false
    @GestureState private var dragState: CGSize = .zero

    //@State private var showMarkdownPreview: Bool = true

    // Automatically hide menu bar(header)
    //  -> Why do we need two state variables for this?
    //  => The HeaderView(), which controls the menu, is stacked on top of the DetectArea(),
    //     which controls the note's resizing. The HeaderView() is hidden when two state variables are 'False'.
    //     When the user's cursor is over the DetectArea(), one of the state variables becomes 'True',
    //     and the HeaderView() becomes visible. Then, to keep the HeaderView() visible,
    //     the remaining state variable becomes 'True'.
    //     When all state variables become 'False', the HeaderView() is automatically hidden.
    //
    //       ------------------------------
    //      /  DetectArea()               /
    //     /     ------------------------------
    //    /     /                             /
    //   /     /     HeaderView()            /
    //  /     /                             /
    // ------/                             /
    //      /                             /
    //      ------------------------------
    //
    @State private var isShowHeader: Bool = false
    @State private var isKeepVisibleHeader: Bool = false

    private let io: DataIO
    private let redoUndoManager: RedoUndo

    private var data: StickyNote
    
    
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
                
                DraggableAreaView()

                VStack(spacing: 0) {

                    if isAutomaticallyHideHeader {
                        if isShowHeader || isKeepVisibleHeader {
                            HeaderView()
                                .onHover { isHover in
                                    withAnimation {
                                        self.isKeepVisibleHeader = isHover
                                        self.isShowHeader = isHover
                                    }
                                }
                        } else {
                            // DetectArea
                            Rectangle()
                                .fill(Color(frameTheme))
                                .frame(width: CGFloat(self.width) + self.dragState.width - 40, height: 7)
                                .onHover { isHover in
                                    withAnimation {
                                        self.isShowHeader = isHover
                                    }
                                }
                        }
                    } else {
                        HeaderView()
                    }

                    if isEnableMarkdown && showMarkdownPreview {
                        MarkdownView()
                            .layoutPriority(1)
                            .foregroundColor(Color(foregroundColorName()))
                            .background(Color(bodyBackgroundTheme), in: RoundedRectangle(cornerRadius: 10))
                            .padding(EdgeInsets(top: 0, leading: 7, bottom: 7, trailing: 7))

                    } else {
                        NoteView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .layoutPriority(1)
                            .font(.system(size: CGFloat(self.fontSize)))
                            .lineSpacing(CGFloat(self.lineSpacing))
                            .foregroundColor(Color(foregroundColorName()))
                            .scrollContentBackground(.hidden)
                            .background(Color(bodyBackgroundTheme), in: RoundedRectangle(cornerRadius: 10))
                            .padding(EdgeInsets(top: 0, leading: 7, bottom: 7, trailing: 7))
                    }
                }
            }
            .frame(width: CGFloat(self.width) + self.dragState.width, height: CGFloat(self.height) + self.dragState.height)
            .gesture(
                DragGesture(minimumDistance: 1)
                    .updating($dragState) { gestureValue, gestureState, gestureTransaction in

                        // Update the size only in the directions the user can drag.
                        var draggedWidth: CGFloat = isDraggableHorizontal ? gestureValue.translation.width : 0
                        var draggedHeight: CGFloat = isDraggableVertical ? gestureValue.translation.height : 0

                        let willUpdateWithWidth: Int = self.width + Int(draggedWidth)
                        let willUpdateWithHeight: Int = self.height + Int(draggedHeight)

                        // The user is not allowed to resize beyond the upper or lower limit.
                        if willUpdateWithWidth > SettingKeys.StickyNote().maxWidth.intValue {
                            draggedWidth = CGFloat(SettingKeys.StickyNote().maxWidth.intValue - self.width)
                        }
                        
                        if willUpdateWithWidth < SettingKeys.StickyNote().minWidth.intValue {
                            draggedWidth = CGFloat(SettingKeys.StickyNote().minWidth.intValue - self.width)
                        }
                        
                        if willUpdateWithHeight > SettingKeys.StickyNote().maxHeight.intValue {
                            draggedHeight = CGFloat(SettingKeys.StickyNote().maxHeight.intValue - self.height)
                        }
                        
                        if willUpdateWithHeight < SettingKeys.StickyNote().minHeight.intValue {
                            draggedHeight = CGFloat(SettingKeys.StickyNote().minHeight.intValue - self.height)
                        }

                        gestureState = CGSize(width: draggedWidth, height: draggedHeight)
                    }
                    .onEnded { endedState in
                        // Update the size only in the directions the user can drag.
                        var draggedWidth = isDraggableHorizontal ? endedState.translation.width : 0
                        var draggedHeight = isDraggableVertical ? endedState.translation.height : 0

                        let willUpdateWithWidth: Int = self.width + Int(draggedWidth)
                        let willUpdateWithHeight: Int = self.height + Int(draggedHeight)
                        
                        // The user is not allowed to resize beyond the upper or lower limit.
                        if willUpdateWithWidth > SettingKeys.StickyNote().maxWidth.intValue {
                            draggedWidth = CGFloat(SettingKeys.StickyNote().maxWidth.intValue - self.width)
                        }
                        
                        if willUpdateWithWidth < SettingKeys.StickyNote().minWidth.intValue {
                            draggedWidth = CGFloat(SettingKeys.StickyNote().minWidth.intValue - self.width)
                        }

                        if willUpdateWithHeight > SettingKeys.StickyNote().maxHeight.intValue {
                            draggedHeight = CGFloat(SettingKeys.StickyNote().maxHeight.intValue - self.height)
                        }
                        
                        if willUpdateWithHeight < SettingKeys.StickyNote().minHeight.intValue {
                            draggedHeight = CGFloat(SettingKeys.StickyNote().minHeight.intValue - self.height)
                        }

                        // Updated to the new size.
                        self.width += Int(draggedWidth)
                        self.height += Int(draggedHeight)

                        // Reset the draggable area and cursor image becouse the user resized the note.
                        self.isDraggableHorizontal = false
                        self.isDraggableVertical = false
                        NSCursor.pop()
                    }
            )
        }
    }
    
    private func HeaderView() -> some View {
        VStack {
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
                
                if !showMarkdownPreview {
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
                }

                if isEnableMarkdown {
                    if showMarkdownPreview {
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(Color(bodyForegroundTheme))
                            .onTapGesture {
                                withAnimation {
                                    showMarkdownPreview.toggle()
                                }
                            }
                    } else {
                        Image(systemName: "m.square")
                            .imageScale(.large)
                            .foregroundColor(Color(bodyForegroundTheme))
                            .onTapGesture {
                                withAnimation {
                                    showMarkdownPreview.toggle()
                                }
                            }
                    }
                }

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
                
                if !showMarkdownPreview {
                    Image(systemName: "eraser")
                        .foregroundColor(Color(bodyForegroundTheme))
                        .onTapGesture {
                            userAction = .ALL_DELETE

                            withAnimation {
                                isShowMessagebar.toggle()
                            }

                            if !isShowMessagebar {
                                userAction = .NONE
                            }
                        }
                }
                
                Image(systemName: "printer")
                    .foregroundColor(Color(bodyForegroundTheme))
                    .onTapGesture {
                        withAnimation {
                            isShowMessagebar = false
                        }
                        
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
                        withAnimation {
                            isShowMessagebar = false
                        }
                        userAction = .NONE
                    }
                    
                } else {
                    Button(action: {
                        withAnimation {
                            isShowMessagebar = false
                        }
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
                    .padding(EdgeInsets(top: 0, leading: 7, bottom: 5, trailing: 7))
                    .onDisappear {
                        userActionDispatcher()
                    }
            }
        }
    }
    
    private func NoteView() -> some View {
        VStack {
            if #available(macOS 14, *) {
                TextEditor(text: $stickyText)
                    .padding(EdgeInsets(top: 5, leading: 1, bottom: 0, trailing: 1))
                    .onChange(of: stickyText) { oldVal, newVal in
                        
                        _ = redoUndoManager.snapshot(of: newVal)
                        
                        if isEnableCalculation {
                            stickyText = calculateFormulaIn(newVal)
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
            } else {
                TextEditor(text: $stickyText)
                    .padding(EdgeInsets(top: 5, leading: 1, bottom: 0, trailing: 1))
                    .onChange(of: stickyText) { val in
                        
                        _ = redoUndoManager.snapshot(of: val)
                        
                        if isEnableCalculation {
                            stickyText = calculateFormulaIn(val)
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
    }
    
    private func MarkdownView() -> some View {
        ScrollView {
            Text(makeMarkdown(text: stickyText, codeBlockTheme: markdownCodeBlockTheme, formulaBlockTheme: markdownFormulaBlockTheme))
                .multilineTextAlignment(.leading)
                .textSelection(.enabled)
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .onTapGesture(count: 2) {
            showMarkdownPreview = false
        }
    }

    // This view defines an area where the user can resize the note by dragging.
    //
    // The "#", "@" and "+" symbol in the diagram below indicates the area of window
    // that the user can resize the note by dragging.
    //
    //    # -> Horizontal resizing only.
    //    + -> Vertical resizing only.
    //    @ -> Resize both horizontal and vertical.
    //
    //    *----------------*
    //    |                #
    //    |                #
    //    |    The Note    #
    //    |                #
    //    |                #
    //    *++++++++++++++++@
    //
    private func DraggableAreaView() -> some View {
        ZStack {
            HStack(alignment: .center) {
                Spacer()
                    .layoutPriority(1)
                
                VStack(alignment: .trailing, spacing: 0) {
                    
                    // Horizontal
                    Rectangle()
                        .fill(Color(frameTheme))
                        .frame(width: 10, height: CGFloat(self.height) + self.dragState.height - 20)
                        .onHover { isHover in
                            if isHover {
                                // Prepare to resize the note.
                                // Perform the reset proccess after the user resize the note.
                                self.isDraggableHorizontal = true
                                NSCursor.resizeLeftRight.push()
                            } else {
                                NSCursor.pop()
                            }
                        }
                    
                    // Horizontal and vertical
                    Rectangle()
                        .fill(Color(frameTheme))
                        .frame(width: 20, height: 20)
                        .onHover { isHover in
                            if isHover {
                                // Prepare to resize the note.
                                // Perform the reset proccess after the user resize the note.
                                self.isDraggableVertical = true
                                self.isDraggableHorizontal = true
                                NSCursor.closedHand.push()
                            } else {
                                NSCursor.pop()
                            }
                        }
                }
            }

            VStack(alignment: .center) {
                Spacer()
                    .layoutPriority(1)
                
                // Vertical
                Rectangle()
                    .fill(Color(frameTheme))
                    .frame(width: CGFloat(self.width) + self.dragState.width - 40, height: 10)
                    .onHover { isHover in
                        if isHover {
                            // Prepare to resize the note.
                            // Perform the reset proccess after the user resize the note.
                            self.isDraggableVertical = true
                            NSCursor.resizeUpDown.push()
                        } else {
                            NSCursor.pop()
                        }
                    }
            }
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
    
    private func foregroundColorName() -> String {
        if isApplyThemeColorToFont {
            return bodyForegroundTheme
            
        } else if isApplyBlackColorToFont {
            return SettingKeys.StickyNote.NoteFontColor.Black().key

        } else if isApplyDarkGrayColorToFont {
            return SettingKeys.StickyNote.NoteFontColor.DarkGray().key

        } else if isApplyGrayColorToFont {
            return SettingKeys.StickyNote.NoteFontColor.Gray().key
            
        } else {
            return bodyForegroundTheme
        }
    }
    
    private func calculateFormulaIn(_ val: String) -> String {
        
        let calculater = CalculateModel(digitAfterDecimalPoint: positionOfRoundsDecimalPoint)
        
        var calculated: String = val
        
        for formulaRange in calculated.getFormulas() {

            if let result = calculater.result(formula: String(calculated[formulaRange])) {
                
                // A splitedIndex is index of formula end.
                // If the note is "abc(1+2=)", the splitedIndex is between "=" and ")".
                let splitIndex = calculated.index(formulaRange.upperBound, offsetBy: 1)

                calculated = "\(String(calculated[calculated.startIndex..<splitIndex])) \(result) \(String(calculated[splitIndex..<calculated.endIndex]))"
                
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
        
        return calculated
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(delegate: AppDelegate())
    }
}
