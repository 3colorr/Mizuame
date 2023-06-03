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

    private var numberFormatter = NumberFormatter()
    
    init() {
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.maximumIntegerDigits = 4
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Sticky Note Size:")
            
            HStack {
                Text("Width:")
                TextField("e.g. \(INIT_WIDTH)", value: $width, formatter: NumberFormatter())
                    .frame(width: 80)
                    .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 10))
                    .onChange(of: width) { val in
                        if val < SettingKeys.StickyNote().minWidth {
                            width = SettingKeys.StickyNote().minWidth
                        }
                        if val > SettingKeys.StickyNote().maxWidth {
                            width = SettingKeys.StickyNote().maxWidth
                        }
                    }
                
                Text("Height:")
                TextField("e.g. \(INIT_HEIGHT)", value: $height, formatter: NumberFormatter())
                    .frame(width: 80)
                    .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 0))
                    .onChange(of: height) { val in
                        if val < SettingKeys.StickyNote().minHeight {
                            height = SettingKeys.StickyNote().minHeight
                        }
                        if val > SettingKeys.StickyNote().maxHeight {
                            height = SettingKeys.StickyNote().maxHeight
                        }
                    }
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
        .frame(width: 400, height: 200)
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
    }
}

struct TabStickyNote_Previews: PreviewProvider {
    static var previews: some View {
        TabStickyNote()
    }
}
