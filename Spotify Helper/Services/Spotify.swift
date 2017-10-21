//
//  Spotify.swift
//  Spotify Helper
//
//  Created by Mavrick Laakso on 2017-10-21.
//  Copyright © Mavrick Laakso. All rights reserved.
//
// This is an wrapper for the application to talk to Spotify's desktop client

import Foundation
import Cocoa

class Spotify {
    private init(){}
}

extension Spotify {
    
    func isRunning() {
        
    }
    
    static func getCurrentlyPlaying() -> SongData {
        if let current = execute(AppleScripts.currentlyPlaying) {
            return current
        } else {
            return SongData()
        }
    }
    
    static private func execute(_ script: String) -> SongData? {
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: script) {
            let output = scriptObject.executeAndReturnError(&error)
            if error != nil {
                print("Error executing apple script")
                print(error as Any)
                return nil
            } else if let data = output.stringValue {
                return SongData(data)
            } else {
                return nil
            }
        }
        return nil
    }
    
}

struct SongData {
    
    public let artist: String?
    public let track: String?
    public let albumUrl: String?
    public let albumImage: NSImage?
    
    init(_ input: String) {
        let split = input.characters.split(separator: "$").map(String.init)
        self.artist = split[0]
        self.track = split[1]
        self.albumUrl = split[2]
        self.albumImage = nil
    }
    
    init() {
        self.artist = "No artist playing"
        self.track = "No track playing"
        self.albumUrl = nil
        self.albumImage = nil
    }
    
    func getTrack() -> String? {
        guard let track = self.track else { return nil }
        return track
    }
    
    func getArtist() -> String? {
        guard let artist = self.artist else { return nil }
        return artist
    }
    
    func getArtistAndTrack() -> String? {
        guard let artist = self.getArtist() else { return "Nothing playing" }
        guard let track = self.getTrack() else { return "Nothing playing" }
        return "\(artist) - \(track)"
    }
    
}
