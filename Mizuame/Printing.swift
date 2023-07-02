//
//  Printing.swift
//  Mizuame
//
//  Created by becomefoolish on 2023/07/02.
//

import AppKit

class Printing {

    func doPrinting(content: String) {
        print("content:\(content)")
        
        let printInfo = NSPrintInfo.shared
        printInfo.scalingFactor = 1.0
        printInfo.topMargin = 1.0
        printInfo.bottomMargin = 1.0
        printInfo.leftMargin = 1.0
        printInfo.rightMargin = 1.0
        printInfo.horizontalPagination = .fit
        printInfo.verticalPagination = .fit
        printInfo.paperSize = NSSize(width: 595, height: 842)
        
        let cc = NSText(frame: NSRect(x: 0, y: 0, width: 595, height: 842))
        cc.string = content

        let printOperation = NSPrintOperation(view: cc, printInfo: printInfo)
        printOperation.showsPrintPanel = true
        printOperation.showsProgressPanel = true
        printOperation.run()
    }

}
