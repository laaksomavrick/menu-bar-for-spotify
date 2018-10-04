//
//  SpotifyPlayerViewController.swift
//  Spotify Helper
//
//  Created by Mavrick Laakso on 2017-10-19.
//  Copyright © 2017 Mavrick Laakso. All rights reserved.
//
//  View controller for the popover - handles data bindings, asking for new state, and reacting to user events

import Cocoa

class SpotifyPlayerViewController: NSViewController {

    @IBOutlet weak var trackTitle: NSTextField!
    @IBOutlet weak var artistTitle: NSTextField!
    @IBOutlet weak var albumArt: NSImageView!
    @IBOutlet weak var toggleText: NSTextField!
    
    let listener = SpotifyEventListener()
    var playerState: PlayerState?
    var current: SongData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listener.delegate = self
        toggleText.alphaValue = 0
        addMouseOverListener()
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

    func addMouseOverListener() {
        let area = NSTrackingArea.init(rect: albumArt.bounds, options: [NSTrackingArea.Options.mouseEnteredAndExited, NSTrackingArea.Options.activeAlways], owner: self, userInfo: nil)
        albumArt.addTrackingArea(area)
    }
    
    override func mouseEntered(with event: NSEvent) {
        handleMouseEnterAlbumArt()
    }
    
    override func mouseExited(with event: NSEvent) {
        handleMouseLeftAlbumArt()
    }
    
    override func mouseDown(with event: NSEvent) {
        //ew
        let localPoint = self.view.convert(event.locationInWindow, to: nil)
        if (localPoint.x > 125 && localPoint.x < 275 && localPoint.y > 125 && localPoint.y < 275) {
            Spotify.togglePlayerState()
            updateState()
        }
    }

}

extension SpotifyPlayerViewController {
    
    func setView() {
        setArtist()
        setTrack()
        setAlbumArt()
        setToggleText()
    }
    
    func updateState() {
        self.current = Spotify.getCurrentlyPlaying()
        self.playerState = Spotify.playerState()
        setView()
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
    
    func setToggleText() {
        guard let playerState = playerState else { return }
        if playerState == .Playing {
            toggleText.stringValue = "Pause"
        } else {
            toggleText.stringValue = "Play"
        }
    }
    
    func handleMouseEnterAlbumArt() {
        setToggleText()
        NSAnimationContext.runAnimationGroup({(_ context: NSAnimationContext) -> Void in
            context.duration = 0.2
            self.albumArt.animator().alphaValue = 0.5
            self.toggleText.animator().alphaValue = 1.0
        }, completionHandler: nil)
    }
    
    func handleMouseLeftAlbumArt() {
        NSAnimationContext.runAnimationGroup({(_ context: NSAnimationContext) -> Void in
            context.duration = 0.2
            self.albumArt.animator().alphaValue = 1.0
            self.toggleText.animator().alphaValue = 0
        }, completionHandler: nil)
        
    }
    
}

extension SpotifyPlayerViewController: SpotifyEventListenerDelegate {
    
    func playbackStateChanged() {
        updateState()
    }
    
}

extension SpotifyPlayerViewController {
    
    static func freshController() -> SpotifyPlayerViewController {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let identifier = "SpotifyPlayerViewController"
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? SpotifyPlayerViewController else {
            fatalError("Why cant i find SpotifyPlayerViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
}
