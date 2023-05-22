//
//  DataIO.swift
//  Mizuame
//
//  Created by becomefoolish on 2023/05/21.
//

import Foundation

// This is DataIO class.
// This class has following that read/write private functions for JSON file.
// JSON file at "Library/Application SUpport" in apps.
//  - func readJSON() -> Data?
//  - func writeJSON(of json: Data) -> Bool
// Also, this class has following that JSON data decode/encode public functions.
//  - func fetchSticky() -> StickyNote?
//  - func writeSticky(data: StickyNote) -> Bool

class DataIO {

    private let stickyNoteJson = "stickyNote.json"

    private func readJSON() -> Data? {
        guard let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
            print("Fatal error: readJSON: Could not get Library/Application Support directory.")
            return nil
        }

        let stikyNoteUrl = url.appendingPathComponent(stickyNoteJson)

        do {
            return try Data(contentsOf: stikyNoteUrl)
        } catch {
            return nil
        }
    }
    
    private func writeJSON(of json: Data) -> Bool {
        guard let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
            print("Fatal error: writeJSON: Could not get Library/Application Support directory.")
            return false
        }
        
        let stikyNoteUrl = url.appendingPathComponent(stickyNoteJson)

        do {
            try json.write(to: stikyNoteUrl)
            return true
        } catch {
            print("Fatal error: Could not write JSON data to file.")
            return false
        }
    }
    
    public func readStickyNote() -> StickNote? {
        return nil
    }
    
    public func writeStickyNote() -> Bool {
        return false
    }
}
