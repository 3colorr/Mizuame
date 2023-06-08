//
//  SettingKeys.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/27.
//

import Foundation

struct SettingKeys {
    struct FontSize {
        let key: String = "fontSize"
        let initialValue: Int = 12
    }

    struct MessageColor {
        let keyTheme: String = "msgColor"
        let initialTheme: String = "Light-Mint-Message"
    }

    struct MessagebarColor {
        let keyTheme: String = "msgbarColor"
        let initialTheme: String = "Light-Mint-Messagebar"
    }

    struct StickyNote {
        let keyWidth: String = "stickyNoteWidth"
        let keyHeight: String = "stickyNoteHeight"
        let initialWidth: Int = 300
        let initialHeight: Int = 150
        let minWidth: Int = 150
        let maxWidth: Int = 1000
        let minHeight: Int = 80
        let maxHeight: Int = 1000
    }
    
    struct ThemePalette {
        struct LightMint {
            let name: String = "Light and Mint"
            let message: String = "Light-Mint-Message"
            let messagebar: String = "Light-Mint-Messagebar"
        }
        struct LightOrange {
            let name: String = "Light and Orange"
            let message: String = "Light-Orange-Message"
            let messagebar: String = "Light-Orange-Messagebar"
        }
    }
    struct UserConfirm {
        let keyAgreement: String = "agreement"
        let initialViewState: Int = SettingsViewState.TERMS_OF_SERVICE.rawValue
    }
}
