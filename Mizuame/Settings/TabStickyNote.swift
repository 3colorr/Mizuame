//
//  TabWindow.swift
//  Mizuame
//
//  Created by becomefoolish on 2023/05/25.
//

import SwiftUI
import StoreKit

struct TabStickyNote: View {
    @AppStorage("stickyNoteWidth") private var width: String = "300"
    @AppStorage("stickyNoteHeight") private var height: String = "150"
    
    private let INIT_WIDTH: String = "300"
    private let INIT_HEIGHT: String = "150"

    var body: some View {
        VStack(alignment: .leading) {
            Text("Sticky Note Size:")
            HStack {
                Text("Width:")
                TextField("e.g. \(INIT_WIDTH)", text: $width)
                    .frame(width: 80)
                    .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 10))
                
                Text("Height:")
                TextField("e.g. \(INIT_HEIGHT)", text: $height)
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
