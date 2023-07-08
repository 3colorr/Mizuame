//
//  Printing.swift
//  Mizuame
//
//  Created by becomefoolish on 2023/07/02.
//

import AppKit

class PrinterModel: ObservableObject {
    
    @Published var scalingFactor = SettingKeys.Printer().initialScalingFactor
    
    // Edit the margins and the centered in the settings tab.
    @Published var topMargin = SettingKeys.Printer().initialTopMargin
    @Published var bottomMargin = SettingKeys.Printer().initialBottomMargin
    @Published var leftMargin = SettingKeys.Printer().initialLeftMargin
    @Published var rightMargin = SettingKeys.Printer().initialRightMargin
    @Published var isVerticallyCentered = SettingKeys.Printer().initialVerticallyCentered
    @Published var isHorizontallyCentered = SettingKeys.Printer().initialHorizontallyCentered

    // Inherit tha current settings.
    @Published var printSize = NSRect(x: 0, y: 0, width: SettingKeys.Printer().pixel72dpiA4.width, height: SettingKeys.Printer().pixel72dpiA4.height)
    @Published var textColor = SettingKeys.StickyNoteColor().initialForegroundTheme
    @Published var textFontSize = SettingKeys.FontSize().initialValue

    func doPrinting(content: String) {
        let printInfo = NSPrintInfo.shared
        printInfo.scalingFactor = self.scalingFactor
        printInfo.topMargin = self.topMargin
        printInfo.bottomMargin = self.bottomMargin
        printInfo.leftMargin = self.leftMargin
        printInfo.rightMargin = self.rightMargin
        printInfo.isVerticallyCentered = self.isVerticallyCentered
        printInfo.isHorizontallyCentered = self.isHorizontallyCentered

        //FYI: 72pt=96px
        let target = NSTextView(frame: self.printSize)
        target.string = content
        target.textColor = NSColor(named: self.textColor)
        target.font = NSFont.systemFont(ofSize: CGFloat(self.textFontSize))
        
        let panel = NSPrintPanel()
        panel.options = [.showsOrientation, .showsPaperSize, .showsPreview, .showsScaling, .showsCopies, .showsPrintSelection, .showsPageRange]
        
        let printOperation = NSPrintOperation(view: target, printInfo: printInfo)
        printOperation.printPanel = panel
        printOperation.run()
    }
}
