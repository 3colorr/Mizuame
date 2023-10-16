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
    
    private var isSkipSnapshot: Bool = false
    
    init(initialNote: String) {
        noteHistories.append(initialNote)
    }
    
    // Store snapshot of notes.
    // If user was executing redo or undo, this function is not store snapshot of note.
    public func snapshot(of note: String) -> Bool {
        
        if isSkipSnapshot {
            isSkipSnapshot = false
            return false
        }
        
        if noteHistories.count == MAX_HISTORIES {
            noteHistories.removeFirst()
            noteHistories.append(note)
            currentIndex = noteHistories.count - 1
            
            return true
        }

        if currentIndex < noteHistories.count - 1 {
            noteHistories.removeSubrange((currentIndex + 1)..<noteHistories.count)
            noteHistories.append(note)
            currentIndex = noteHistories.count - 1

            return true
        }
        

        noteHistories.append(note)
        currentIndex += 1

        return true
    }
    
    // Return a next generation note.
    // If there is no next generation, return the current generation.
    public func redo() -> String {
        if currentIndex + 1 < MAX_HISTORIES {
            currentIndex += 1
        }
        
        isSkipSnapshot = true
        
        return noteHistories[currentIndex]
    }
    
    // Return a previous generation note.
    // If there is no previous generation, return the current generation.
    public func undo() -> String {
        if currentIndex > 0 {
            currentIndex -= 1
        }

        isSkipSnapshot = true

        return noteHistories[currentIndex]
    }
}
