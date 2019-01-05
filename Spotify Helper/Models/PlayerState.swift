//
//  PlayerState.swift
//  Spotify Helper
//
//  Created by Mavrick Laakso on 2017-10-22.
//  Copyright © 2017 Mavrick Laakso. All rights reserved.
//
//  Data structure representing the player's state

// cr: should be in songdata class top level; only used here

import Foundation

enum PlayerState: String {
    case Playing = "playing", Paused = "paused", Stopped = "stopped"
}
