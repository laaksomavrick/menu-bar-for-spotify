//
//  SpotifyEventListener.swift
//  Spotify Helper
//
//  Created by Mavrick Laakso on 2017-10-21.
//  Copyright © 2017 Mavrick Laakso. All rights reserved.
//
//  Monitors playback changes in app / spotify client and notifies listeners via delegate

import Foundation
import Cocoa

public class SpotifyEventListener {
    
    private var listener: DistributedNotificationCenter?
    private let playbackChanged = NSNotification.Name(rawValue: "com.spotify.client.PlaybackStateChanged")
    
    // dt: delegates
    var delegate: SpotifyEventListenerDelegate?
    
    public init() {
        start()
    }
    
    deinit {
        stop()
    }
    
}

extension SpotifyEventListener {
    
    public func start() {
        listener = DistributedNotificationCenter.default()
        // cr: handle failure case
        // dt: safe access
        listener?.addObserver(self,
                              selector: #selector(playbackStateChanged),
                              name: playbackChanged,
                              object: nil)
    }
    
    public func stop() {
        if listener != nil {
            listener?.removeObserver(self, name: playbackChanged, object: nil)
            listener = nil
        }
    }
    
    @objc public func playbackStateChanged(notification: NSNotification) {
        // cr: throw on failure
        delegate?.playbackStateChanged()
    }
    
}

// dt: delegates / protocols (advanced interfaces / abstract interfaces)
protocol SpotifyEventListenerDelegate {
    func playbackStateChanged()
}


