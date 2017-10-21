//
//  SpotifyPlayerViewController.swift
//  Spotify Helper
//
//  Created by Mavrick Laakso on 2017-10-19.
//  Copyright © Mavrick Laakso. All rights reserved.
//

import Cocoa

class SpotifyPlayerViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}

extension SpotifyPlayerViewController {
    // MARK: Storyboard instantiation
    static func freshController() -> SpotifyPlayerViewController {
        //1.
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        //2.
        let identifier = NSStoryboard.SceneIdentifier(rawValue: "SpotifyPlayerViewController")
        //3.
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? SpotifyPlayerViewController else {
            fatalError("Why cant i find SpotifyPlayerViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
}
