//
//  Spotify.swift
//  Spotify Helper
//
//  Created by Mavrick Laakso on 2017-10-21.
//  Copyright © 2017 Mavrick Laakso. All rights reserved.
//
//  Wwrapper for the application to talk to (get/set) Spotify's desktop client

import Foundation
import Cocoa

class Spotify {
    private init(){}
}

extension Spotify {
    
    static func isRunning() -> Bool {
        return executeIsRunning(AppleScripts.isRunning)
    }
    
    static func playerState() -> PlayerState? {
        return executePlayerState(AppleScripts.playerState)
    }
    
    static func togglePlayerState() {
        execute(AppleScripts.togglePlayerState)
    }
    
    static func previousTrack() {
        execute(AppleScripts.previousTrack)
    }
    
    static func nextTrack() {
        execute(AppleScripts.nextTrack)
    }
    
    static func getCurrentlyPlaying() -> SongData {
        guard isRunning() == true else { return SongData() }
        if let current = executeSongData(AppleScripts.currentlyPlaying) {
            return current
        } else {
            return SongData()
        }
    }
    
    static private func executeSongData(_ script: String) -> SongData? {
        // cr: so much copy paste; can just simplify by having this as a function which takes a function
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
    
    static private func executePlayerState(_ script: String) -> PlayerState? {
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: script) {
            let output = scriptObject.executeAndReturnError(&error)
            if error != nil {
                print("Error executing apple script")
                print(error as Any)
                return nil
            } else if let data = output.stringValue {
                return PlayerState(rawValue: data)
            } else {
                return nil
            }
        }
        return nil
    }
    
    static private func executeIsRunning(_ script: String) -> Bool {
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: script) {
            let output = scriptObject.executeAndReturnError(&error)
            if error != nil {
                print("Error executing apple script")
                print(error as Any)
                return false
            } else if let data = output.stringValue, let value = Bool(data) {
                return value
            } else {
                return false
            }
        }
        return false
    }
    
    static private func execute(_ script: String) {
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: script) {
            let _ = scriptObject.executeAndReturnError(&error)
            if error != nil {
                print("Error executing apple script")
                print(error as Any)
            }
        }
    }
    
}


