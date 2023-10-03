//
//  Printing.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/07/02.
//

import AppKit

class PrinterModel: ObservableObject {
    
    @Published var scalingFactor: Int = SettingKeys.Printer().initialScalingFactor
    
    // Edit the margins and the centered in the settings tab.
    @Published var topMargin: Int = SettingKeys.Printer().initialTopMargin
    @Published var bottomMargin: Int = SettingKeys.Printer().initialBottomMargin
    @Published var leftMargin:Int = SettingKeys.Printer().initialLeftMargin
    @Published var rightMargin:Int = SettingKeys.Printer().initialRightMargin
    @Published var isVerticallyCentered: Bool = SettingKeys.Printer().initialVerticallyCentered
    @Published var isHorizontallyCentered: Bool = SettingKeys.Printer().initialHorizontallyCentered

    // Inherit tha current settings.
    @Published var printSize = NSRect(x: 0, y: 0, width: SettingKeys.Printer().pixel72dpiA4.width, height: SettingKeys.Printer().pixel72dpiA4.height)
    @Published var textColor = SettingKeys.StickyNoteColor().initialForegroundTheme
    @Published var textFontSize = SettingKeys.FontSize().initialValue

    func doPrinting(content: String) {
        let printInfo = NSPrintInfo.shared
        printInfo.topMargin = CGFloat(self.topMargin)
        printInfo.bottomMargin = CGFloat(self.bottomMargin)
        printInfo.leftMargin = CGFloat(self.leftMargin)
        printInfo.rightMargin = CGFloat(self.rightMargin)

        // Why divide by 100.0?
        // The scaling-factor is in % and 1 treated as 100%.
        // And the apps save value of scaling-factor in %.
        // Therefore, the value of scaling-factor divide by 100.
        printInfo.scalingFactor = CGFloat(self.scalingFactor) / 100.0

        // Centered
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
