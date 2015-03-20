//
//  AppDelegate.swift
//  Noisily
//
//  Created by Adam Ahrens on 3/4/15.
//  Copyright (c) 2015 Appsbyahrens. All rights reserved.
//

import UIKit
import Realm

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        createData()
        return true
    }
    
    func createData() {
        let key = "hasLoaded"
        if NSUserDefaults.standardUserDefaults().boolForKey(key) {
            return
        }
        
        let fire = Noise()
        fire.name = "Fire"
        fire.fileName = "fire"
        fire.fileType = "mp4"
        fire.imageName = "Fire"
        
        let waves = Noise()
        waves.name = "Waves"
        waves.fileName = "waves"
        waves.fileType = "mp4"
        waves.imageName = "Waves"
        
        let thunder = Noise()
        thunder.name = "Thunder"
        thunder.fileName = "thunder"
        thunder.fileType = "mp4"
        thunder.imageName = "Thunder"
        
        let coffee = Noise()
        coffee.name = "Coffee Shop"
        coffee.fileName = "coffee-shop"
        coffee.fileType = "mp4"
        coffee.imageName = "Coffee"
        
        let rain = Noise()
        rain.name = "Rain"
        rain.fileName = "rain"
        rain.fileType = "mp4"
        rain.imageName = "Rain"
        
        let bird = Noise()
        bird.name = "Birds"
        bird.fileName = "birds"
        bird.fileType = "mp4"
        bird.imageName = "Bird"
        
        let lunch = Noise()
        lunch.name = "Cafeteria"
        lunch.fileName = "lunch-crowd"
        lunch.fileType = "mp3"
        lunch.imageName = "Lunch"
        
        let whale = Noise()
        whale.name = "Whale"
        whale.fileName = "Whale"
        whale.fileType = "mp3"
        whale.imageName = "Whale"
        
        let realm = RLMRealm.defaultRealm()
        realm.beginWriteTransaction()
        realm.addObject(fire)
        realm.addObject(waves)
        realm.addObject(thunder)
        realm.addObject(coffee)
        realm.addObject(rain)
        realm.addObject(bird)
        realm.addObject(lunch)
        realm.addObject(whale)
        realm.commitWriteTransaction()
        
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: key)
    }

    func applicationWillResignActive(application: UIApplication) {

    }

    func applicationDidEnterBackground(application: UIApplication) {

    }

    func applicationWillEnterForeground(application: UIApplication) {

    }

    func applicationDidBecomeActive(application: UIApplication) {

    }

    func applicationWillTerminate(application: UIApplication) {
       
    }
}

