//
//  StickyNotePreview.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/31.
//

import SwiftUI

struct StickyNotePreview: View {
    let fontSize: Int
    let width: CGFloat
    let height: CGFloat
    let message: String
    let messagebar: String

    init(fontSize: Int, width: Int, height: Int, msg: String, bar: String) {

        self.fontSize = fontSize
        self.message = msg
        self.messagebar = bar

        // Calcurate a ratio width to height for preview of window size
        // This is NOT correct.
        let ratioWtoH: Double = Double(height) / Double(width)
        if ratioWtoH < 0.5 {
            let preWidth = 200.0 * (1 / ratioWtoH)
            let preHeight = 100.0
            
            if preWidth > 250.0 {
                self.width = 250.0
                self.height = 100.0 * ratioWtoH
            } else {
                self.width = preWidth
                self.height = preHeight
            }
            
        } else if ratioWtoH < 1.0 {
            self.width = 200.0
            self.height = 150.0

        } else if ratioWtoH > 1.5 {
            let preWidth = 200.0
            let preHeight = 100.0 * ratioWtoH
            
            if preHeight > 150.0 {
                self.width = 200.0 * (1 / ratioWtoH)
                self.height = 150.0
            } else {
                self.width = preWidth
                self.height = preHeight
            }

        } else if ratioWtoH > 1.0 {
            self.width = 150.0
            self.height = 200.0

        } else {
            self.width = 150
            self.height = 150
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(Color(red: 0.9, green: 0.9, blue: 0.9))
                .frame(width: width, height: height)
            
            VStack(spacing: 0) {
                Spacer()
                    .frame(width: width, height: height / 5)
                
                Text("settings.tab.stickynote.window.preview.messagebar")
                    .frame(width: width, height: height / 5)
                    .font(.system(size: CGFloat(fontSize)))
                    .foregroundColor(Color(message))
                    .background(Color(messagebar))
                
                Text("settings.tab.stickynote.window.preview.stickynote")
                    .frame(width: width, height: height * 3 / 5)
                    .font(.system(size: CGFloat(fontSize)))
                    .background(Color.white)
            }
        }
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(style: StrokeStyle(lineWidth: 1))
                .fill(Color.black)
        }
    }
}
