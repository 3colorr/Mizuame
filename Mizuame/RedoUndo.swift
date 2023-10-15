//
//  RedoUndo.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/10/15.
//

import Foundation

class RedoUndo {
    private let MAX_HISTORIES: Int = 30
    
    private var currentIndex: Int = 0
    private var noteHistories: [String] = []
    
    init(initialNote: String) {
        noteHistories.append(initialNote)
    }
    
    // Store snapshot of notes.
    public func snapshot(of note: String) -> Bool {
            return false
    }
    
    // Return a next generation note.
    // If there is no next generation, return the current generation.
    public func redo() -> String {
        return ""
    }
    
    // Return a previous generation note.
    // If there is no previous generation, return the current generation.
    public func undo() -> String {
        return ""
    }
}
