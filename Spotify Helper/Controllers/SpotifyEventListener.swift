//
//  SpotifyEventListener.swift
//  Spotify Helper
//
//  Created by Mavrick Laakso on 2017-10-21.
//  Copyright © Mavrick Laakso. All rights reserved.
//

import Foundation
import Cocoa

public class SpotifyEventListener {
    
    private var listener: DistributedNotificationCenter?
    private let playbackChanged = NSNotification.Name(rawValue: "com.spotify.client.PlaybackStateChanged")
    
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
        delegate?.playbackStateChanged()
    }
    
}

protocol SpotifyEventListenerDelegate {
    func playbackStateChanged()
}


