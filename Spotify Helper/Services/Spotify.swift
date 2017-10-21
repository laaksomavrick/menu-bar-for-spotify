//
//  Spotify.swift
//  Spotify Helper
//
//  Created by Mavrick Laakso on 2017-10-21.
//  Copyright © Mavrick Laakso. All rights reserved.
//

import Foundation

class Spotify {
    
    static let conn = Spotify()
    
    private init(){}
    
}

extension Spotify {
    
    func currentlyPlaying() {
        
        let myAppleScript = """
        
        tell application "Spotify"
          play track "spotify:track:51pQ7vY7WXzxskwloaeqyj"
        end tell
        
        """
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: myAppleScript) {
            if let output: NSAppleEventDescriptor = scriptObject.executeAndReturnError(
                &error) {
                print(output.stringValue)
            } else if (error != nil) {
                print("error: \(error)")
            }
        }
        
    }
    
}
