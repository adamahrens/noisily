//
//  NoisePlayManager.swift
//  Noisily
//
//  Created by Adam Ahrens on 3/19/15.
//  Copyright (c) 2015 Appsbyahrens. All rights reserved.
//

import AVFoundation

class NoisePlayerManager: NSObject, AVAudioPlayerDelegate {
    private var players = [String : AVAudioPlayer]()
    
    /**
    Toggles playing the noise. If currently playing turns it off, otherwise on
    */
    func toggleNoise(noise: Noise) {
        let noiseResource = noise.soundFilePath()
        var error: NSError?
        
        // Already have a player going for the noise
        if let player = players[noise.name] {
            player.stop()
            players[noise.name] = nil
        } else {
            // Need to start a new player
            let player = AVAudioPlayer(contentsOfURL: noiseResource, error: &error)
            player.volume = 0.5
            player.numberOfLoops = -1
            player.delegate = self
            player.prepareToPlay()
            player.play()
            players[noise.name] = player
        }
        
        if (error != nil) {
           println("Error constructing player \(error)")
        }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        println("Finished Playing")
    }
}