//
//  SettingsViewStyle.swift
//  Mizuame
//
//  Created by becomefoolish on 2023/09/30.
//

import SwiftUI

struct SettingsLinkStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(.clear)
    }
}
