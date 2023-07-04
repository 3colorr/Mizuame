//
//  Printing.swift
//  Mizuame
//
//  Created by becomefoolish on 2023/07/02.
//

import AppKit

class PrinterModel: ObservableObject {
    
    @Published var scalingFactor = 1.0
    @Published var topMargin = 1.0
    @Published var bottomMargin = 1.0
    @Published var leftMargin = 1.0
    @Published var rightMargin = 1.0
    @Published var paperSize = NSSize(width: 595, height: 842)
    @Published var targetSize = NSRect(x: 0, y: 0, width: 595, height: 842)
    @Published var textColor = SettingKeys.StickyNoteColor().initialForegroundTheme

    func doPrinting(content: String) {
        print("content:\(content)")
        
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
