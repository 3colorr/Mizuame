//
//  TabWindow.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/25.
//

import SwiftUI
import StoreKit

struct TabStickyNote: View {
    @AppStorage(SettingKeys.StickyNote().keyWidth) private var width: Int =  SettingKeys.StickyNote().initialWidth
    @AppStorage(SettingKeys.StickyNote().keyHeight) private var height: Int = SettingKeys.StickyNote().initialHeight
    
    private let INIT_WIDTH: Int = SettingKeys.StickyNote().initialWidth
    private let INIT_HEIGHT: Int = SettingKeys.StickyNote().initialHeight

    var body: some View {
        VStack(alignment: .leading) {
            Text("Sticky Note Size:")
            
            // FIX ME!!
            // TextField() want to receive only numelic values.
            HStack {
                Text("Width:")
                TextField("e.g. \(INIT_WIDTH)", value: $width, formatter: NumberFormatter())
                    .frame(width: 80)
                    .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 10))
                
                Text("Height:")
                TextField("e.g. \(INIT_HEIGHT)", value: $height, formatter: NumberFormatter())
                    .frame(width: 80)
                    .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 0))
            }
            
            Spacer()

            Text("Reset: ")
            Button(action: {
                self.width = INIT_WIDTH
                self.height = INIT_HEIGHT
            }) {
                Text("Reset Width and Height to initial value")
                    .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
            }
        }
        .padding(EdgeInsets(top: 10, leading: 50, bottom: 10, trailing: 50))
    }
}

struct TabStickyNote_Previews: PreviewProvider {
    static var previews: some View {
        TabStickyNote()
    }
}
