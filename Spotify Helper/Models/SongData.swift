//
//  SongData.swift
//  Spotify Helper
//
//  Created by Mavrick Laakso on 2017-10-21.
//  Copyright © 2017 Mavrick Laakso. All rights reserved.
//
//  Data structure representing a song + associated convenience functions on that type

import Foundation
import Cocoa

// dt: structs are data types (stack; immutable); classes are value types (heap; like const in js)
struct SongData {
    
    public let artist: String?
    public let track: String?
    public let albumUrl: String?
    
    init(_ input: String) {
        let split = input.split(separator: "$").map(String.init)
        self.artist = split[safe: 0]
        self.track = split[safe: 1]
        self.albumUrl = split[safe: 2]
    }
    
    init() {
        self.artist = "No artist playing"
        self.track = "No track playing"
        self.albumUrl = nil
    }
    
    func getTrack() -> String? {
        // cr: should just return self.track
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
        let header = "\(artist) - \(track)"
        
        if header.count > 30 {
            let difference = 30 - header.count
            let endIndex = header.index(header.endIndex, offsetBy: difference)
            let truncated = header[...endIndex]
            return "\(truncated)..."
        } else {
            return header
        }
    }
    
    public func getAlbumImage(completion: @escaping (_ error: Bool, _ image: NSImage?) -> ()) {
        guard let fragment = albumUrl else { return }
        guard let url = URL(string: fragment) else { return }
        Network.getDataFromUrl(url: url) { data, response, error in
            // dt: manual threading code for async; callbacks; async await still not in the language (but has long running proposal / is coming)
            DispatchQueue.main.async() {
                guard let data = data, error == nil else {
                    completion(true, nil)
                    return
                }
                completion(false, NSImage(data: data))
            }
        }
    }
    
}
