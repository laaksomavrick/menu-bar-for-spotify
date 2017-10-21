//
//  AppDelegate.swift
//  Spotify Helper
//
//  Created by Mavrick Laakso on 2017-10-19.
//  Copyright © 2017 Lucid Development. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let view = SpotifyMenuButton()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        view.set()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}

