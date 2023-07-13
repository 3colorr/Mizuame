//
//  SettingKeys.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/27.
//

import Foundation

struct SettingKeys {
    struct Menubar {
        let keySavingMessage: String = "saving-message"
        let initialSavingMessage: Bool = true
    }
    
    struct Printer {
        let keyTextColorApplyBlack: String = "print-text-color-apply-black"
        let keyScalingFactor: String = "print-scaling-factor"
        let keyTopMargin: String = "print-top-margin"
        let keyBottomMargin: String = "print-bottom-margin"
        let keyLeftMargin: String = "print-left-margin"
        let keyRightMargin: String = "print-right-margin"
        let keyVerticallyCentered: String = "print-vertically-centered"
        let keyHorizontallyCentered: String = "print-horizontally-centered"

        let initialTextColorApplyBlack: Bool = false
        let initialScalingFactor: Int = 100
        let initialTopMargin: Int = 20
        let initialBottomMargin: Int = 20
        let initialLeftMargin: Int = 20
        let initialRightMargin: Int = 20
        let initialVerticallyCentered: Bool = false
        let initialHorizontallyCentered: Bool = false

        
        //pixel A4 72dpi
        let pixel72dpiA4 = (width: 595.0, height: 842.0)
        
    }
    
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
        struct WhitePink {
            let name: String = "White and Pink"
            let message: String = "White-Pink-Message"
            let messagebar: String = "White-Pink-Messagebar"
            let foreground: String = "White-Pink-Foreground"
            let background: String = "White-Pink-Background"
            let frame: String = "White-Pink-Frame"
        }
        struct WhiteBlue {
            let name: String = "White and Blue"
            let message: String = "White-Blue-Message"
            let messagebar: String = "White-Blue-Messagebar"
            let foreground: String = "White-Blue-Foreground"
            let background: String = "White-Blue-Background"
            let frame: String = "White-Blue-Frame"
        }
        struct WhiteMint {
            let name: String = "White and Mint"
            let message: String = "White-Mint-Message"
            let messagebar: String = "White-Mint-Messagebar"
            let foreground: String = "White-Mint-Foreground"
            let background: String = "White-Mint-Background"
            let frame: String = "White-Mint-Frame"
        }
        struct WhiteYellow {
            let name: String = "White and Yellow"
            let message: String = "White-Yellow-Message"
            let messagebar: String = "White-Yellow-Messagebar"
            let foreground: String = "White-Yellow-Foreground"
            let background: String = "White-Yellow-Background"
            let frame: String = "White-Yellow-Frame"
        }
    }
    struct UserConfirm {
        let keyAgreement: String = "agreement"
        let initialViewState: Int = SettingsViewState.TERMS_OF_SERVICE.rawValue
    }
}
