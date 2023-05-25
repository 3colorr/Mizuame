//
//  TabWindow.swift
//  Mizuame
//
//  Created by becomefoolish on 2023/05/25.
//

import SwiftUI

struct TabStickyNote: View {
    @State private var width: String
    @State private var height: String
    
    init() {
        _width = State(initialValue: "300")
        _height = State(initialValue: "150")
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Sticky Note Size:")
            HStack {
                Text("Width:")
                TextField("e.g. 300", text: $width)
                    .frame(width: 50)
                    .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 10))
                
                Text("Height:")
                TextField("e.g. 150", text: $height)
                    .frame(width: 50)
                    .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 0))
            }
        }
        .padding(10)
    }
}

struct TabStickyNote_Previews: PreviewProvider {
    static var previews: some View {
        TabStickyNote()
    }
}
