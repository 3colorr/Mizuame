//
//  MizuameApp.swift
//  Mizuame
//
//  Created by becomefoolish on 2023/05/07.
//

import SwiftUI

//@main
//struct MizuameApp: App {
//    let persistenceController = PersistenceController.shared
//
//    var body: some Scene {
//        MenuBarExtra("Mizuame", systemImage: "text.bubble") {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//        }
//    }
//}

@main
struct Mizuame: App {

    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        Settings {
            SettingsView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    
    private var statusItem: NSStatusItem?
    private var popover: NSPopover = NSPopover()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
            
        guard let unwrapped = statusItem else {
            return
        }
        
        if let button = unwrapped.button {
            button.image = NSImage(systemSymbolName: "text.bubble", accessibilityDescription: nil)
            button.action = #selector(showPopover)
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
     
        popover.contentViewController = NSHostingController(rootView: ContentView())
        popover.behavior = .transient
    }
    
    @objc func showPopover(sender: NSStatusBarButton) {
        guard let currentEvent = NSApp.currentEvent else {
            return
        }
        
        guard let unwrappedStatusItem = statusItem else {
            return
        }
        
        if currentEvent.type == NSEvent.EventType.rightMouseUp {
            print("Event -> rightMouseUp")

            let menu = NSMenu()
            menu.addItem(
                withTitle: "Preferences",
                action: #selector(showSettings),
                keyEquivalent: ""
            )
            menu.addItem(.separator())
            menu.addItem(
                withTitle: "Quit",
                action: #selector(quitApp),
                keyEquivalent: ""
            )
            
            unwrappedStatusItem.menu = menu
            unwrappedStatusItem.button?.performClick(nil)
            unwrappedStatusItem.menu = nil
            
        } else if currentEvent.type == NSEvent.EventType.leftMouseUp {
            print("Event -> leftMouseUp")
            popover.show(relativeTo: sender.bounds, of: sender, preferredEdge: NSRectEdge.maxY)
            popover.contentViewController?.view.window?.makeKey()
        }
    }
    
    @objc func quitApp() {
        NSApp.terminate(self)
    }
    
    @objc func showSettings() {
        // Sending `showSettingsWindow:` to the `Selector` render the settings UI.
        // `showSettingsWindow:` is reserved action name.
        // Sending other strings (e.g. `showSettings`) to the `Selector` will not render the settings UI.
        NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
        
        // The settings move to front.
        NSApp.activate(ignoringOtherApps: true)
    }
}
