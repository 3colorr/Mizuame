//
//  TabGeneral.swift
//  Mizuame
//
//  Created by becomefoolish on 2023/05/25.
//

import SwiftUI
import StoreKit

struct TabGeneral: View {
    @AppStorage(SettingKeys.FontSize().key) private var fontSize: Int = SettingKeys.FontSize().initialValue

    private let INIT_FONT_SIZE: Int = SettingKeys.FontSize().initialValue
    
    var body: some View {
        VStack(alignment: .leading) {
            Picker("Font Size: ", selection: $fontSize) {
                ForEach(1..<40, id: \.self) { num in
                    Text("\(num)")
                }
            }
            .frame(width: 150)
            
            Spacer()

            Text("Reset: ")
            Button(action: {
                self.fontSize = INIT_FONT_SIZE
            }) {
                Text("Reset Font size to initial value")
                    .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
            }
        }
        .padding(EdgeInsets(top: 10, leading: 50, bottom: 10, trailing: 50))
    }
}

struct TabGeneral_Previews: PreviewProvider {
    static var previews: some View {
        TabGeneral()
    }
}
