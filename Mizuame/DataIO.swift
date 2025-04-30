//
//  DataIO.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/21.
//

import Foundation
import AppKit

// This is DataIO class.
// This class has following that read/write private functions for JSON file.
// JSON file at "Library/Application SUpport" in apps.
//  - func readJSON() -> Data?
//  - func writeJSON(of json: Data) -> Bool
// Also, this class has following that JSON data decode/encode public functions.
//  - func fetchSticky() -> StickyNote?
//  - func writeSticky(of data: StickyNote) -> Bool

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
    
    public func readStickyNote() -> StickyNote? {
        guard let json = readJSON() else {
            print("Fatal error: Failed to read JSON data.")
            return nil
        }
        
        let jsonDecoder = JSONDecoder()

        do {
            return try jsonDecoder.decode(StickyNote.self, from: json)
            
        } catch {
            print("Fatal error: Failed to encode data to JSON")
            return nil
        }
    }
    
    public func writeStickyNote(of data: StickyNote) -> Bool {
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(data)
            return writeJSON(of: data)
            
        } catch {
            print("Fatal error: Failed to encode data to JSON")
            return false
        }
    }

    @MainActor
    public func exportNote(data: StickyNote) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd-HHmmss"

        let savePanel = NSSavePanel()
        savePanel.canCreateDirectories = true
        savePanel.allowedContentTypes = [.json]
        savePanel.nameFieldStringValue = "mizuame-notes-\(dateFormatter.string(from: Date())).json"
        savePanel.title = String(localized: "sitickynote.savepanel.title")

        if savePanel.runModal() == .OK, let url = savePanel.url {
            do {
                let encoder = JSONEncoder()
                let json = try encoder.encode(data)
                try json.write(to: url)
                return true
            } catch {
                print("Error saving file: \(error)")
                return false
            }
        }
        
        return false
    }

    @MainActor
    public func importNote() -> StickyNote? {
        let openPanel = NSOpenPanel()
        openPanel.allowedContentTypes = [.json]
        openPanel.title = String(localized: "sitickynote.openpanel.title")
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = false

        if openPanel.runModal() == .OK, let url = openPanel.urls.first {
            do {
                let json = try Data(contentsOf: url)
                let jsonDecoder = JSONDecoder()
                return try jsonDecoder.decode(StickyNote.self, from: json)
            } catch {
                print("Fatal error: Failed to encode data to JSON: \(error)")
                return nil
            }
        }
        
        return nil
    }
}
