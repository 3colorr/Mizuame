//
//  SettingKeys.swift
//  Mizuame
//
//  Created by becomefoolish on 2023/05/27.
//

import Foundation

struct SettingKeys {
    struct FontSize {
        let key: String = "fontSize"
        let initialValue: Int = 11
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
