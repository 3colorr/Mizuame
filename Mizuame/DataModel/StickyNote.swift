//
//  StickyNote.swift
//  Mizuame
//
//  Created by becomefoolish on 2023/05/21.
//

import Foundation

struct StickyNote: Codable {
    var tab: Int
    var contents: [Content]
}

struct Content: Codable {
    var markercolor: String
    var body: String
}
