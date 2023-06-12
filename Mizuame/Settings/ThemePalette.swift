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
    @Binding var bodyForeground: String
    @Binding var bodyBackground: String

    @State var isCheckedLightMint: Bool
    @State var isCheckedLightOrange: Bool

    init(checked: String, message: Binding<String>, messagebar: Binding<String>, bodyForeground: Binding<String>, bodyBackground: Binding<String>) {
        _message = message
        _messagebar = messagebar
        _bodyForeground = bodyForeground
        _bodyBackground = bodyBackground

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
                bodyForeground = lightMint.foreground
                bodyBackground = lightMint.background
                
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
                bodyForeground = lightOrange.foreground
                bodyBackground = lightOrange.background
                
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
        ThemePalette(checked: "checked", message: .constant("message"), messagebar: .constant("messagebar"), bodyForeground: .constant("foreground"), bodyBackground: .constant("background"))
    }
}
