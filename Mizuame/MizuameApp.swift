//
//  MizuameApp.swift
//  Mizuame
//
//  Created by Nakamura Akira(3colorr) on 2023/05/07.
//

import SwiftUI
import StoreKit

@main
struct Mizuame: App {

    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        Settings {
            SettingsView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {

    @AppStorage(SettingKeys.UserConfirm().keyAgreement) private var viewState: Int = SettingKeys.UserConfirm().initialViewState
    
    @AppStorage(SettingKeys.StickyNote().keyPinNote) private var isPinNote: Bool = SettingKeys.StickyNote().initialPinNote

    private var statusItem: NSStatusItem?
    private var popover: NSPopover = NSPopover()
    
    private var isOpenNote: Bool = true
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
            
        guard let unwrapped = statusItem else {
            return
        }
        
        if let button = unwrapped.button {
            //button.image = NSImage(systemSymbolName: "text.bubble", accessibilityDescription: nil)
            button.image = NSImage(named: "MenubarIcon")
            button.action = #selector(showPopover)
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
     
        popover.contentViewController = NSHostingController(rootView: ContentView())
        
        if isPinNote {
            enablePinning()
        } else {
            disablePinning()
        }
    }
    
    @objc func showPopover(sender: NSStatusBarButton) {
        guard let currentEvent = NSApp.currentEvent else {
            return
        }
        
        guard let unwrappedStatusItem = statusItem else {
            return
        }
        
        if currentEvent.type == NSEvent.EventType.rightMouseUp {

            let menu = NSMenu()
            
            // If the user don't agree terms of service and privacy policy,
            // Mizuame don't show preferences.
            if viewState == SettingsViewState.PREFERENCE.rawValue {
                menu.addItem(
                    withTitle: NSLocalizedString("menubar.clickevent.right.menu.item.preference", comment: ""),
                    action: #selector(showSettings),
                    keyEquivalent: ""
                )
                menu.addItem(.separator())
            }
            
            menu.addItem(
                withTitle: NSLocalizedString("menubar.clickevent.right.menu.item.quit", comment: ""),
                action: #selector(quitApp),
                keyEquivalent: ""
            )
            
            unwrappedStatusItem.menu = menu
            unwrappedStatusItem.button?.performClick(nil)
            unwrappedStatusItem.menu = nil
            
        } else if currentEvent.type == NSEvent.EventType.leftMouseUp {
            if isOpenNote {
                popover.show(relativeTo: sender.bounds, of: sender, preferredEdge: NSRectEdge.maxY)
            } else {
                popover.close()
            }

            isOpenNote.toggle()

            // The note will not close if the following are disable.
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
    
    // when a user tap the desktop, close note if popover.behavior is .transient.
    // when a user tap the desktop, NOT close note if popover.behavior is .applicationDefined.
    func enablePinning() {
        popover.behavior = .applicationDefined
    }
    
    func disablePinning() {
        popover.behavior = .transient
    }
}
