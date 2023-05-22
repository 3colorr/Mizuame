//
//  StickyNote.swift
//  Mizuame
//
//  Created by becomefoolish on 2023/05/21.
//

import Foundation

struct StickyNote: Codable {
    private var tab: Int
    private var contents: [Content]
}

struct Content: Codable {
    private var markercolor: String
    private var body: String
}
