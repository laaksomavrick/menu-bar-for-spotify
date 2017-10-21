//
//  Spotify.swift
//  Spotify Helper
//
//  Created by Mavrick Laakso on 2017-10-21.
//  Copyright © 2017 Mavrick Laakso. All rights reserved.
//
// This is an wrapper for the application to talk to Spotify's desktop client

import Foundation
import Cocoa

class Spotify {
    private init(){}
}

extension Spotify {
    
    func isRunning() {
        //todo
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


