//
//  Applescripts.swift
//  Spotify Helper
//
//  Created by Mavrick Laakso on 2017-10-21.
//  Copyright © 2017 Lucid Development. All rights reserved.
//

import Foundation

struct AppleScripts {
    
    static let currentlyPlaying =
    """
        tell application "Spotify"
            set currentArtist to artist of current track as string
            set currentTrack to name of current track as string
            return currentArtist & " - " & currentTrack
        end tell
    """
    
}

