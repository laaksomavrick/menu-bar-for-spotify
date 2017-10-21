//
//  Spotify.swift
//  Spotify Helper
//
//  Created by Mavrick Laakso on 2017-10-21.
//  Copyright © Mavrick Laakso. All rights reserved.
//

import Foundation

class Spotify {
    private init(){}
}

extension Spotify {
    
    func isRunning() {
        
    }
    
    static func getCurrentlyPlaying() {
        execute(AppleScripts.currentlyPlaying)
    }
    
    static private func execute(_ script: String) {
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: script) {
            let output = scriptObject.executeAndReturnError(&error)
            if error != nil {
                print("Error executing apple script")
                print(error as Any)
                print(output)
            } else {
                print(output)
            }
        }
    }
    
}
