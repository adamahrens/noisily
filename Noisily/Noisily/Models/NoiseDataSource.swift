//
//  NoiseDataSource.swift
//  Noisily
//
//  Created by Adam Ahrens on 3/19/15.
//  Copyright (c) 2015 Appsbyahrens. All rights reserved.
//

import Foundation

public class NoiseDataSource {
  
    private let noises = Noise.allObjects()
    private let noiseManager = NoisePlayerManager()
    private var noiseVolumes = [String: Double]()
    
    init () {
        for noise in noises {
            let n = noise as Noise
            noiseVolumes[n.name] = 0.4
        }
    }
    
    /**
    How many sections of noises
    */
    func numberOfSections() -> Int {
        return 1
    }
    
    /**
    How many noises
    */
    func numberOfNoises() -> Int {
        return Int(noises.count)
    }
    
    /**
    Determines if a noise is currently playing
    */
    func noiseIsPlaying(indexPath: NSIndexPath) -> Bool {
        let selectedNoise = noiseAtIndexPath(indexPath)
        return noiseManager.noiseIsPlaying(selectedNoise)
    }
    
    /**
    Toggles a sound on/off with it's current volume level
    */
    func toggleNoiseAtIndexPath(indexPath : NSIndexPath) {
        let selectedNoise = noiseAtIndexPath(indexPath)
        noiseManager.toggleNoise(selectedNoise)
        noiseManager.adjustVolumeLevel(selectedNoise, volume: currentVolumeForNoise(selectedNoise))
    }
    
    /**
    Retrieves a noise at an indexPath
    */
    func noiseAtIndexPath(indexPath: NSIndexPath) -> Noise {
        return noises[UInt(indexPath.row)] as Noise
    }
    
    /**
    Retrieves the current volume level for the Noise
    */
    func currentVolumeForNoise(noise: Noise) -> Double {
        return noiseVolumes[noise.name]!
    }
    
    /**
    Updates the volume for a current Noise. If it's playing, adjusts appropriately
    */
    func updateVolumeForNoise(noise: Noise, volume: Double) {
        noiseManager.adjustVolumeLevel(noise, volume: volume)
        noiseVolumes[noise.name] = volume
    }
}
