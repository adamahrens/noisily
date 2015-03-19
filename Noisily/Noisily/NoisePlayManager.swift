//
//  NoisePlayManager.swift
//  Noisily
//
//  Created by Adam Ahrens on 3/19/15.
//  Copyright (c) 2015 Appsbyahrens. All rights reserved.
//

import AVFoundation

class NoisePlayerManager: NSObject, AVAudioPlayerDelegate {
    
    private var player: AVAudioPlayer?
    
    /**
    Toggles playing the noise. If currently playing turns it off, otherwise on
    */
    func toggleNoise(noise: Noise) {
        let noiseResource = noise.soundFilePath()
        var error: NSError?
        player = AVAudioPlayer(contentsOfURL: noiseResource, error: &error)
        if let play = player {
            play.volume = 0.5
            play.numberOfLoops = -1
            play.delegate = self
            play.prepareToPlay()
            play.play()
        }
        
        if (error != nil) {
           println("Error constructing player \(error)")
        }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        println("Finished Playing")
    }
}