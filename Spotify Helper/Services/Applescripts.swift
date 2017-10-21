//
//  Applescripts.swift
//  Spotify Helper
//
//  Created by Mavrick Laakso on 2017-10-21.
//  Copyright © 2017 Lucid Development. All rights reserved.
//
// The script constants that are executed to get / set Spotify's state

import Foundation

struct AppleScripts {
    
    static let currentlyPlaying =
    """
        tell application "Spotify"
            set currentArtist to artist of current track as string
            set currentTrack to name of current track as string
            set currentAlbumUrl to artwork url of current track as string
            return currentArtist & "$" & currentTrack & "$" & currentAlbumUrl
        end tell
    """
    
}

