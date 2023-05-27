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
        let initialWidth: String = "300"
        let initialHeight: String = "150"
        let initialNumberWidth: CGFloat = 300
        let initialNumberHeigh: CGFloat = 150
    }
}
