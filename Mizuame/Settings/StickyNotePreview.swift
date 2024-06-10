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
    let bodyForeground: String
    let bodyBackground: String
    let bodyFrame: String

    init(fontSize: Int, width: Int, height: Int, message: String, messagebar: String, bodyForeground: String, bodyBackground: String, bodyFrame: String) {

        self.fontSize = fontSize
        self.message = message
        self.messagebar = messagebar
        self.bodyForeground = bodyForeground
        self.bodyBackground = bodyBackground
        self.bodyFrame = bodyFrame

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
                .fill(Color(bodyFrame))
                .frame(width: width, height: height)
            
            VStack(spacing: 0) {
                Spacer()
                    .frame(width: width, height: height / 6)
                
                Text("settings.tab.stickynote.window.preview.messagebar")
                    .frame(width: width * 0.95, height: height / 6)
                    .font(.system(size: CGFloat(fontSize)))
                    .foregroundColor(Color(message))
                    .background(Color(messagebar))
                    .padding(5)

                Text("settings.tab.stickynote.window.preview.stickynote")
                    .frame(width: width * 0.95, height: height * 3.35 / 6)
                    .font(.system(size: CGFloat(fontSize)))
                    .foregroundColor(Color(bodyForeground))
                    .background(Color(bodyBackground))
            }
        }
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(style: StrokeStyle(lineWidth: 1))
                .fill(Color.black)
        }
    }
}
