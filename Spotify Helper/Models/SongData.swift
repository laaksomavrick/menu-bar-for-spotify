//
//  SongData.swift
//  Spotify Helper
//
//  Created by Mavrick Laakso on 2017-10-21.
//  Copyright © 2017 Mavrick Laakso. All rights reserved.
//

import Foundation
import Cocoa

struct SongData {
    
    public let artist: String?
    public let track: String?
    public let albumUrl: String?
    
    init(_ input: String) {
        let split = input.characters.split(separator: "$").map(String.init)
        self.artist = split[0]
        self.track = split[1]
        self.albumUrl = split[2]
    }
    
    init() {
        self.artist = "No artist playing"
        self.track = "No track playing"
        self.albumUrl = nil
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
    
    public func getAlbumImage(completion: @escaping (_ error: Bool, _ image: NSImage?) -> ()) {
        guard let fragment = albumUrl else { return }
        guard let url = URL(string: fragment) else { return }
        Network.getDataFromUrl(url: url) { data, response, error in
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
