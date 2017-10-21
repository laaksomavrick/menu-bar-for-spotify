//
//  MenuButtonView.swift
//  Spotify Helper
//
//  Created by Mavrick Laakso on 2017-10-21.
//  Copyright © 2017 Lucid Development. All rights reserved.
//

import Foundation
import Cocoa

class SpotifyMenuButton {
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.variableLength)
    let popover = NSPopover()
}

extension SpotifyMenuButton {
    
    //MARK: - view initialization related functions (data bindings / view init)
    
    func set() {
        setTitle()
        setPopover()
    }
    
    func setTitle() {
        if let button = statusItem.button {
            button.title = "hi bb"
            button.action = #selector(self.togglePopover(_:))
            button.target = self
        }
    }
    
    func setPopover() {
        popover.contentViewController = SpotifyPlayerViewController.freshController()
    }
    
}

extension SpotifyMenuButton {
    
    //MARK: - view action related functions (controller)

    @objc func togglePopover(_ sender: Any?) {
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }
    
    func showPopover(sender: Any?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    func closePopover(sender: Any?) {
        popover.performClose(sender)
    }
    
}
