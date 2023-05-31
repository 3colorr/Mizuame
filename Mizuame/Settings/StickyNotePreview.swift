//
//  StickyNotePreview.swift
//  Mizuame
//
//  Created by becomefoolish on 2023/05/31.
//

import SwiftUI

struct StickyNotePreview: View {
    let fontSize: Int
    let msgR: Double
    let msgG: Double
    let msgB: Double
    let barR: Double
    let barG: Double
    let barB: Double
    
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(Color(red: 0.9, green: 0.9, blue: 0.9))
                .frame(width: 200, height: 100)
            
            VStack(spacing: 0) {
                Spacer()
                    .frame(width: 200, height: 20)
                
                Text("Messagebar")
                    .frame(width: 200, height: 20)
                    .font(.system(size: CGFloat(fontSize)))
                    .foregroundColor(Color(red: msgR, green: msgG, blue: msgB))
                    .background(Color(red: barR, green: barG, blue: barB))
                
                Text("StickyNote")
                    .frame(width: 200, height: 60)
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
