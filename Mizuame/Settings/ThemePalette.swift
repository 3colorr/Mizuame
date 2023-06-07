//
//  ThemePalette.swift
//  Mizuame
//
//  Created by becomefoolish on 2023/06/07.
//

import SwiftUI

struct ThemePalette: View {
    @Binding var message: String
    @Binding var messagebar: String

    @State var isCheckedLightMint: Bool = false
    
    var body: some View {
        Button(action: {
            isCheckedLightMint.toggle()
            
        }, label: {
            if isCheckedLightMint {
                Image(systemName: "checkmark.square.fill")
            } else {
                Image(systemName: "square")
            }
            Text(SettingKeys.ThemePalette.LightMint().name).font(.body)
        })
    }
}

struct ThemePalette_Previews: PreviewProvider {
    static var previews: some View {
        ThemePalette(message: .constant("message"), messagebar: .constant("messagebar"))
    }
}
