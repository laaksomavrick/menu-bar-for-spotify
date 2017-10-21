//
//  SpotifyPlayerViewController.swift
//  Spotify Helper
//
//  Created by Mavrick Laakso on 2017-10-19.
//  Copyright © 2017 Mavrick Laakso. All rights reserved.
//

import Cocoa

class SpotifyPlayerViewController: NSViewController {
    
    //todo: pause on hover
    //todo: fix popover reposition on skip
    //todo: shuffle / repeat toggle?
    
    @IBOutlet weak var trackTitle: NSTextField!
    @IBOutlet weak var artistTitle: NSTextField!
    @IBOutlet weak var albumArt: NSImageView!
    
    let listener = SpotifyEventListener()
    var current: SongData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listener.delegate = self
    }
    
    override func viewWillAppear() {
        updateState()
    }
    
    @IBAction func didSelectPrevious(_ sender: Any) {
        Spotify.previousTrack()
    }
    
    @IBAction func didSelectNext(_ sender: Any) {
        Spotify.nextTrack()
    }
    
    func updateState() {
        self.current = Spotify.getCurrentlyPlaying()
        setView()
    }
    
}

extension SpotifyPlayerViewController {
    
    func setView() {
        setArtist()
        setTrack()
        setAlbumArt()
    }
    
    func setArtist() {
        guard let artist = current?.getArtist() else { return }
        artistTitle.stringValue = artist
    }
    
    func setTrack() {
        guard let track = current?.getTrack() else { return }
        trackTitle.stringValue = track
    }
    
    func setAlbumArt() {
        current?.getAlbumImage() { error, image in
            guard let image = image else { return }
            self.albumArt.image = image
        }
    }
    
}

extension SpotifyPlayerViewController: SpotifyEventListenerDelegate {
    
    func playbackStateChanged() {
        updateState()
    }
    
}

extension SpotifyPlayerViewController {
    
    static func freshController() -> SpotifyPlayerViewController {
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier(rawValue: "SpotifyPlayerViewController")
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? SpotifyPlayerViewController else {
            fatalError("Why cant i find SpotifyPlayerViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
}
