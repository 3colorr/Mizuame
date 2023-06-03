//
//  TabWindow.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/25.
//

import SwiftUI
import StoreKit

struct TabGeneral: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("General tab")
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
