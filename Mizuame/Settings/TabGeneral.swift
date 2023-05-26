//
//  TabGeneral.swift
//  Mizuame
//
//  Created by becomefoolish on 2023/05/25.
//

import SwiftUI
import StoreKit

struct TabGeneral: View {
    @AppStorage("fontSize") private var fontSize: Int = 11

    var body: some View {
        VStack(alignment: .leading) {
            Picker("Font Size: ", selection: $fontSize) {
                ForEach(1..<40, id: \.self) { num in
                    Text("\(num)")
                }
            }
            .frame(width: 150)
        }
        .padding(10)
    }
}

struct TabGeneral_Previews: PreviewProvider {
    static var previews: some View {
        TabGeneral()
    }
}
