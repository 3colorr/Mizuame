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
        let keyR: String = "msgColorR"
        let keyG: String = "msgColorG"
        let keyB: String = "msgColorB"
        let initialR: Double = 0.0
        let initialG: Double = 0.0
        let initialB: Double = 0.0
    }

    struct MessagebarColor {
        let keyR: String = "msgbarColorR"
        let keyG: String = "msgbarColorG"
        let keyB: String = "msgbarColorB"
        let initialR: Double = 0.750
        let initialG: Double = 0.885
        let initialB: Double = 0.860
    }

    struct StickyNote {
        let keyWidth: String = "stickyNoteWidth"
        let keyHeight: String = "stickyNoteHeight"
        let initialWidth: Int = 300
        let initialHeight: Int = 150
    }
    
    struct UserConfirm {
        let keyAgreement: String = "agreement"
        let initialViewState: Int = SettingsViewState.TERMS_OF_SERVICE.rawValue
    }
}
