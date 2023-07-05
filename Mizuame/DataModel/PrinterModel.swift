//
//  Printing.swift
//  Mizuame
//
//  Created by becomefoolish on 2023/07/02.
//

import AppKit

class PrinterModel: ObservableObject {
    
    @Published var scalingFactor = SettingKeys.Printer().initialScalingFactor
    
    @Published var topMargin = SettingKeys.Printer().initialTopMargin
    @Published var bottomMargin = SettingKeys.Printer().initialBottomMargin
    @Published var leftMargin = SettingKeys.Printer().initialLeftMargin
    @Published var rightMargin = SettingKeys.Printer().initialRightMargin
    
    @Published var paperSize = NSSize(width: SettingKeys.Printer().pixel72dpiA4.width, height: SettingKeys.Printer().pixel72dpiA4.height)
    
    @Published var targetSize = NSRect(x: 0, y: 0, width: SettingKeys.Printer().pixel72dpiA4.width, height: SettingKeys.Printer().pixel72dpiA4.height)
    
    @Published var textColor = SettingKeys.StickyNoteColor().initialForegroundTheme

    func doPrinting(content: String) {
        let printInfo = NSPrintInfo.shared
        printInfo.scalingFactor = self.scalingFactor
        printInfo.topMargin = self.topMargin
        printInfo.bottomMargin = self.bottomMargin
        printInfo.leftMargin = self.leftMargin
        printInfo.rightMargin = self.rightMargin
        printInfo.horizontalPagination = .fit
        printInfo.verticalPagination = .fit
        printInfo.paperSize = self.paperSize

        let target = NSText(frame: self.targetSize)
        target.string = content
        target.textColor = NSColor(named: self.textColor)

        let printOperation = NSPrintOperation(view: target, printInfo: printInfo)
        printOperation.showsPrintPanel = true
        printOperation.showsProgressPanel = true
        printOperation.run()
    }
}
