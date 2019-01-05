//
//  AppDelegate.swift
//  Spotify Helper
//
//  Created by Mavrick Laakso on 2017-10-19.
//  Copyright © 2017 Mavrick Laakso. All rights reserved.
//
//  Application entry point

// dt: file > new in xcode

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let view = SpotifyMenuButton()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        view.set()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        view.exit()
    }

}

