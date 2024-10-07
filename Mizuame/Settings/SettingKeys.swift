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
        let initialTheme: String = "White-Mint-Message"
    }

    struct MessagebarColor {
        let keyTheme: String = "msgbarColor"
        let initialTheme: String = "White-Mint-Messagebar"
    }

    struct StickyNoteColor {
        let keyForeground: String = "foregroundColor"
        let keyBackground: String = "BackgroundColor"
        let initialForegroundTheme: String = "White-Mint-Foreground"
        let initialBackgroundTheme: String = "White-Mint-Background"
    }

    struct MarkdownViewColor {
        let keyCodeBlock: String = "codeblockColor"
        let keyFormulaBlock: String = "formulablockColor"
        let initialCodeBlockTheme: String = "Markdown-Gray"
        let initialFormulaBlockTheme: String = "Markdown-Mint"
    }

    struct FrameColor {
        let keyTheme: String = "frameColor"
        let initialTheme: String = "White-Mint-Frame"
    }

    struct StickyNote {
        let keyLineSpacing: String = "linespacing"
        let initialLineSpacing: Int = 2
        
        let keyWidth: String = "stickyNoteWidth"
        let keyHeight: String = "stickyNoteHeight"
        let initialWidth: Int = 300
        let initialHeight: Int = 150
        let minWidth: NSNumber = 250
        let maxWidth: NSNumber = 1000
        let minHeight: NSNumber = 100
        let maxHeight: NSNumber = 1000
        
        let keyPinNote: String = "stickyNotePin"
        let initialPinNote: Bool = false

        let keyLoginItems: String = "stickyNoteLoginItems"
        let initialLoginItems: Bool = false

        let keyAutomaticallyHideHeader = "automaticallyHideTheHeader"
        let initialAutomaticallyHideHeader: Bool = false

        struct NoteFontColor {
            struct Theme {
                let key: String = "stickyNoteFontColorTheme"
                let initialVale: Bool = true
            }
            struct Black {
                let key: String = "stickyNoteFontColorBlack"
                let initialVale: Bool = false
                let ColorDefinition: String = "Note-Font-Color-Black"
            }
            struct DarkGray {
                let key: String = "stickyNoteFontColorDarkGray"
                let initialVale: Bool = false
                let ColorDefinition: String = "Note-Font-Color-Dark-Gray"
            }
            struct Gray {
                let key: String = "stickyNoteFontColorGray"
                let initialVale: Bool = false
                let ColorDefinition: String = "Note-Font-Color-Gray"
            }
        }

        let keyCalculateAction: String = "stickyNoteCalculateAction"
        let initialCalculateAction: Bool = false
        
        let keyPositionOfRoundsDecimalPoint: String = "stickyNotePositionOfRoundsDecimalPoint"
        let initialPositionOfRoundsDecimalPoint: Int = 3

        let keyMarkdownAction: String = "stickyNoteMarkdownAction"
        let initialMarkdownAction: Bool = false
        let keyShowMarkdownPreview: String = "stickyNoteShowMarkdownPreview"
        let initialShowMarkdownPreview: Bool = true
    }
    
    struct ThemePalette {
        struct LightMint {
            let name: String = "Light and Mint"
            let message: String = "Light-Mint-Message"
            let messagebar: String = "Light-Mint-Messagebar"
            let foreground: String = "Light-Mint-Foreground"
            let background: String = "Light-Mint-Background"
            let frame: String = "Light-Mint-Frame"

            let markdownCodeBlock: String = "Markdown-Mint"
            let markdownFormulaBlock: String = "Markdown-Gray"
        }
        struct LightOrange {
            let name: String = "Light and Orange"
            let message: String = "Light-Orange-Message"
            let messagebar: String = "Light-Orange-Messagebar"
            let foreground: String = "Light-Orange-Foreground"
            let background: String = "Light-Orange-Background"
            let frame: String = "Light-Orange-Frame"

            let markdownCodeBlock: String = "Markdown-Orange"
            let markdownFormulaBlock: String = "Markdown-Gray"
        }
        struct LightBlue {
            let name: String = "Light and Blue"
            let message: String = "Light-Blue-Message"
            let messagebar: String = "Light-Blue-Messagebar"
            let foreground: String = "Light-Blue-Foreground"
            let background: String = "Light-Blue-Background"
            let frame: String = "Light-Blue-Frame"

            let markdownCodeBlock: String = "Markdown-Blue"
            let markdownFormulaBlock: String = "Markdown-Gray"
        }
        struct LightYellow {
            let name: String = "Light and Yellow"
            let message: String = "Light-Yellow-Message"
            let messagebar: String = "Light-Yellow-Messagebar"
            let foreground: String = "Light-Yellow-Foreground"
            let background: String = "Light-Yellow-Background"
            let frame: String = "Light-Yellow-Frame"

            let markdownCodeBlock: String = "Markdown-Yellow"
            let markdownFormulaBlock: String = "Markdown-Gray"
        }
        struct MintMint {
            let name: String = "Mint and Mint"
            let message: String = "Mint-Mint-Message"
            let messagebar: String = "Mint-Mint-Messagebar"
            let foreground: String = "Mint-Mint-Foreground"
            let background: String = "Mint-Mint-Background"
            let frame: String = "Mint-Mint-Frame"

            let markdownCodeBlock: String = "Markdown-Mint"
            let markdownFormulaBlock: String = "Markdown-Gray"
        }
        struct OrangeOrange {
            let name: String = "Orange and Orange"
            let message: String = "Orange-Orange-Message"
            let messagebar: String = "Orange-Orange-Messagebar"
            let foreground: String = "Orange-Orange-Foreground"
            let background: String = "Orange-Orange-Background"
            let frame: String = "Orange-Orange-Frame"

            let markdownCodeBlock: String = "Markdown-Orange"
            let markdownFormulaBlock: String = "Markdown-Gray"
        }
        struct BlueBlue {
            let name: String = "Blue and Blue"
            let message: String = "Blue-Blue-Message"
            let messagebar: String = "Blue-Blue-Messagebar"
            let foreground: String = "Blue-Blue-Foreground"
            let background: String = "Blue-Blue-Background"
            let frame: String = "Blue-Blue-Frame"

            let markdownCodeBlock: String = "Markdown-Blue"
            let markdownFormulaBlock: String = "Markdown-Gray"
        }
        struct YellowYellow {
            let name: String = "Yellow and Yellow"
            let message: String = "Yellow-Yellow-Message"
            let messagebar: String = "Yellow-Yellow-Messagebar"
            let foreground: String = "Yellow-Yellow-Foreground"
            let background: String = "Yellow-Yellow-Background"
            let frame: String = "Yellow-Yellow-Frame"

            let markdownCodeBlock: String = "Markdown-Yellow"
            let markdownFormulaBlock: String = "Markdown-Gray"
        }
        struct WhitePink {
            let name: String = "White and Pink"
            let message: String = "White-Pink-Message"
            let messagebar: String = "White-Pink-Messagebar"
            let foreground: String = "White-Pink-Foreground"
            let background: String = "White-Pink-Background"
            let frame: String = "White-Pink-Frame"

            let markdownCodeBlock: String = "Markdown-Pink"
            let markdownFormulaBlock: String = "Markdown-Gray"
        }
        struct WhiteBlue {
            let name: String = "White and Blue"
            let message: String = "White-Blue-Message"
            let messagebar: String = "White-Blue-Messagebar"
            let foreground: String = "White-Blue-Foreground"
            let background: String = "White-Blue-Background"
            let frame: String = "White-Blue-Frame"

            let markdownCodeBlock: String = "Markdown-Light-Blue"
            let markdownFormulaBlock: String = "Markdown-Gray"
        }
        struct WhiteMint {
            let name: String = "White and Mint"
            let message: String = "White-Mint-Message"
            let messagebar: String = "White-Mint-Messagebar"
            let foreground: String = "White-Mint-Foreground"
            let background: String = "White-Mint-Background"
            let frame: String = "White-Mint-Frame"

            let markdownCodeBlock: String = "Markdown-Light-Mint"
            let markdownFormulaBlock: String = "Markdown-Gray"
        }
        struct WhiteYellow {
            let name: String = "White and Yellow"
            let message: String = "White-Yellow-Message"
            let messagebar: String = "White-Yellow-Messagebar"
            let foreground: String = "White-Yellow-Foreground"
            let background: String = "White-Yellow-Background"
            let frame: String = "White-Yellow-Frame"

            let markdownCodeBlock: String = "Markdown-Light-Yellow"
            let markdownFormulaBlock: String = "Markdown-Gray"
        }
    }
    struct UserConfirm {
        let keyAgreement: String = "agreement"
        let initialViewState: Int = SettingsViewState.TERMS_OF_SERVICE.rawValue
    }
}
