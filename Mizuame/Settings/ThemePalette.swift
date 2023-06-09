//
//  ThemePalette.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/06/07.
//

import SwiftUI

struct ThemePalette: View {
    @Binding var message: String
    @Binding var messagebar: String

    @State var isCheckedLightMint: Bool
    @State var isCheckedLightOrange: Bool

    init(msg: Binding<String>, msgbar: Binding<String>, checked: String) {
        _message = msg
        _messagebar = msgbar

        if checked == SettingKeys.ThemePalette.LightOrange().message {
            _isCheckedLightMint = State(initialValue: false)
            _isCheckedLightOrange = State(initialValue: true)
        } else {
            _isCheckedLightMint = State(initialValue: true)
            _isCheckedLightOrange = State(initialValue: false)
        }
    }
    
    var body: some View {
        VStack {
            Button(action: {
                isCheckedLightMint = true
                isCheckedLightOrange = false
                
                let lightMint = SettingKeys.ThemePalette.LightMint()
                message = lightMint.message
                messagebar = lightMint.messagebar
                
            }, label: {
                if isCheckedLightMint {
                    Image(systemName: "checkmark.square.fill")
                } else {
                    Image(systemName: "square")
                }
                Text(SettingKeys.ThemePalette.LightMint().name).font(.body)
            })
            .buttonStyle(.plain)
            
            Button(action: {
                isCheckedLightMint = false
                isCheckedLightOrange = true
                
                let lightOrange = SettingKeys.ThemePalette.LightOrange()
                message = lightOrange.message
                messagebar = lightOrange.messagebar
                
            }, label: {
                if isCheckedLightOrange {
                    Image(systemName: "checkmark.square.fill")
                } else {
                    Image(systemName: "square")
                }
                Text(SettingKeys.ThemePalette.LightOrange().name).font(.body)
            })
            .buttonStyle(.plain)
        }
    }
}

struct ThemePalette_Previews: PreviewProvider {
    static var previews: some View {
        ThemePalette(msg: .constant("message"), msgbar: .constant("messagebar"), checked: "checked")
    }
}
