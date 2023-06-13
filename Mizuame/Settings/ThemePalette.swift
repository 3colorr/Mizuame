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
    @Binding var bodyFrame: String

    init(message: Binding<String>, messagebar: Binding<String>, bodyForeground: Binding<String>, bodyBackground: Binding<String>, bodyFrame: Binding<String>) {
        _message = message
        _messagebar = messagebar
        _bodyForeground = bodyForeground
        _bodyBackground = bodyBackground
        _bodyFrame = bodyFrame
    }
    
    var body: some View {
        VStack {
            Button(action: {
                let lightMint = SettingKeys.ThemePalette.LightMint()
                message = lightMint.message
                messagebar = lightMint.messagebar
                bodyForeground = lightMint.foreground
                bodyBackground = lightMint.background
                bodyFrame = lightMint.frame
                
            }, label: {
                if message == SettingKeys.ThemePalette.LightMint().message {
                    Image(systemName: "checkmark.square.fill")
                } else {
                    Image(systemName: "square")
                }
                Text(SettingKeys.ThemePalette.LightMint().name).font(.body)
            })
            .buttonStyle(.plain)
            
            Button(action: {
                let lightOrange = SettingKeys.ThemePalette.LightOrange()
                message = lightOrange.message
                messagebar = lightOrange.messagebar
                bodyForeground = lightOrange.foreground
                bodyBackground = lightOrange.background
                bodyFrame = lightOrange.frame
                
            }, label: {
                if message == SettingKeys.ThemePalette.LightOrange().message {
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
        ThemePalette(message: .constant("message"), messagebar: .constant("messagebar"), bodyForeground: .constant("foreground"), bodyBackground: .constant("background"), bodyFrame: .constant("frame"))
    }
}
