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

    struct StickyNoteColor {
        let keyForeground: String = "foregroundColor"
        let keyBackground: String = "BackgroundColor"
        let initialForegroundTheme: String = "Light-Mint-Foreground"
        let initialBackgroundTheme: String = "Light-Mint-Background"
    }

    struct FrameColor {
        let keyTheme: String = "frameColor"
        let initialTheme: String = "Light-Mint-Frame"
    }

    struct StickyNote {
        let keyLineSpacing: String = "linespacing"
        let initialLineSpacing: Int = 2
        
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
            let foreground: String = "Light-Mint-Foreground"
            let background: String = "Light-Mint-Background"
            let frame: String = "Light-Mint-Frame"
        }
        struct LightOrange {
            let name: String = "Light and Orange"
            let message: String = "Light-Orange-Message"
            let messagebar: String = "Light-Orange-Messagebar"
            let foreground: String = "Light-Orange-Foreground"
            let background: String = "Light-Orange-Background"
            let frame: String = "Light-Orange-Frame"
        }
        struct LightBlue {
            let name: String = "Light and Blue"
            let message: String = "Light-Blue-Message"
            let messagebar: String = "Light-Blue-Messagebar"
            let foreground: String = "Light-Blue-Foreground"
            let background: String = "Light-Blue-Background"
            let frame: String = "Light-Blue-Frame"
        }
        struct LightYellow {
            let name: String = "Light and Yellow"
            let message: String = "Light-Yellow-Message"
            let messagebar: String = "Light-Yellow-Messagebar"
            let foreground: String = "Light-Yellow-Foreground"
            let background: String = "Light-Yellow-Background"
            let frame: String = "Light-Yellow-Frame"
        }
        struct MintMint {
            let name: String = "Mint and Mint"
            let message: String = "Mint-Mint-Message"
            let messagebar: String = "Mint-Mint-Messagebar"
            let foreground: String = "Mint-Mint-Foreground"
            let background: String = "Mint-Mint-Background"
            let frame: String = "Mint-Mint-Frame"
        }
        struct OrangeOrange {
            let name: String = "Orange and Orange"
            let message: String = "Orange-Orange-Message"
            let messagebar: String = "Orange-Orange-Messagebar"
            let foreground: String = "Orange-Orange-Foreground"
            let background: String = "Orange-Orange-Background"
            let frame: String = "Orange-Orange-Frame"
        }
        struct BlueBlue {
            let name: String = "Blue and Blue"
            let message: String = "Blue-Blue-Message"
            let messagebar: String = "Blue-Blue-Messagebar"
            let foreground: String = "Blue-Blue-Foreground"
            let background: String = "Blue-Blue-Background"
            let frame: String = "Blue-Blue-Frame"
        }
        struct YellowYellow {
            let name: String = "Yellow and Yellow"
            let message: String = "Yellow-Yellow-Message"
            let messagebar: String = "Yellow-Yellow-Messagebar"
            let foreground: String = "Yellow-Yellow-Foreground"
            let background: String = "Yellow-Yellow-Background"
            let frame: String = "Yellow-Yellow-Frame"
        }
    }
    struct UserConfirm {
        let keyAgreement: String = "agreement"
        let initialViewState: Int = SettingsViewState.TERMS_OF_SERVICE.rawValue
    }
}
