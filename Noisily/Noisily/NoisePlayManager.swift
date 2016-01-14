//
//  NoisePlayManager.swift
//  Noisily
//
//  Created by Adam Ahrens on 3/19/15.
//  Copyright (c) 2015 Appsbyahrens. All rights reserved.
//

import AVFoundation

class NoisePlayerManager: NSObject, AVAudioPlayerDelegate {
    private var players = [Noise : AVAudioPlayer]()
    
    /**
    Toggles playing the noise. If currently playing turns it off, otherwise on
    
    - parameter noise: The Noise to toggle on/off
    */
    func toggleNoise(noise: Noise) {
        let noiseResource = noise.soundFilePath()
        var error: NSError?
        
        // Already have a player going for the noise
        if let player = players[noise] {
            player.stop()
            players[noise] = nil
        } else {
            // Need to start a new player
            let player: AVAudioPlayer!
            do {
                player = try AVAudioPlayer(contentsOfURL: noiseResource)
            } catch let error1 as NSError {
                error = error1
                player = nil
            }
            player.volume = 0.5
            player.numberOfLoops = -1
            player.delegate = self
            player.prepareToPlay()
            player.play()
            players[noise] = player
        }
        
        if (error != nil) {
           print("Error constructing player \(error)")
        }
    }
    
    /**
    Determines if a noise is currently playing
    */
    func noiseIsPlaying(noise: Noise) -> Bool {
        return players[noise] != nil
    }
    
    /**
    Adjusts the volume level of a noise if it's currently playing
    
    - parameter noise: The Noise to adjust
    - parameter volume: Volume level between 0.0 and 1.0 (inclusive)
    */
    func adjustVolumeLevel(noise: Noise, volume: Double) {
        if let player = players[noise] {
            assert(volume >= 0.0 && volume <= 1.0, "Volume has to been in 0.0 - 1.0 range")
            player.volume = Float(volume)
        }
    }
}