//
//  MenuButtonView.swift
//  Spotify Helper
//
//  Created by Mavrick Laakso on 2017-10-21.
//  Copyright © 2017 Mavrick Laakso. All rights reserved.
//
//  View controller for the menu bar - handles data bindings, asking for new state, and reacting to user events

import Cocoa

// cr: should be postfixed with controller
class SpotifyMenuButton {
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let popover = NSPopover()
    
    var userInterfaceEventListener: UserInterfaceEventListener?
    let spotifyEventListener = SpotifyEventListener()
    var current: SongData?
    
}

// dt: extensions idiomatic

extension SpotifyMenuButton {
    
    //MARK: - view initialization related functions (data bindings / view init)
    
    // cr: should be in a constructor
    func set() {
        self.current = Spotify.getCurrentlyPlaying()
        setButton()
        setPopover()
        setUserInterfaceEventListener()
        setSpotifyEventListener()
    }
    
    // dt: my very naive tick method => an event happened, update everything
    // there are better patterns for this (e.g react's render system)
    // i've seen lots of observables in more experienced swift code
    func updateState() {
        self.current = Spotify.getCurrentlyPlaying()
        setTitle()
    }
    
    func setButton() {
        if let button = statusItem.button {
            setTitle()
            button.action = #selector(self.togglePopover(_:))
            button.target = self
        }
    }
    
    func setTitle() {
        if let button = statusItem.button, let header = current?.getArtistAndTrack() {
            button.title = header
        }
    }
    
    func setPopover() {
        popover.contentViewController = SpotifyPlayerViewController.freshController()
    }
    
    // dt: mounts a callback on an event; weak self discussion (reference counting)
    func setUserInterfaceEventListener() {
        userInterfaceEventListener = UserInterfaceEventListener(mask : [.leftMouseDown, .rightMouseDown]) { [weak self] event in
            if let this = self, this.popover.isShown {
                this.closePopover(sender: event)
            }
        }
    }
    
    // dt: delegates
    func setSpotifyEventListener() {
        spotifyEventListener.delegate = self
    }
    
    func exit() {
        Darwin.exit(0)
    }
    
}

extension SpotifyMenuButton: SpotifyEventListenerDelegate {
    
    func playbackStateChanged() {
        updateState()
    }
    
}

extension SpotifyMenuButton {
    
    //MARK: - view action related functions (controller)

    // dt: objc interop/compat
    @objc func togglePopover(_ sender: Any?) {
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }
    
    func showPopover(sender: Any?) {
        // dt: guard let more powerful if err != nil pattern
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            userInterfaceEventListener?.start()
        }
    }
    
    func closePopover(sender: Any?) {
        popover.performClose(sender)
        userInterfaceEventListener?.stop()
    }
    
}
