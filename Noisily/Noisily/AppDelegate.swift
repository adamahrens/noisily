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
        let fire = Noise()
        fire.name = "Fire"
        fire.fileName = "fire"
        fire.fileType = "mp4"
        fire.imageName = "Fire"
        
        let realm = RLMRealm.defaultRealm()
        realm.beginWriteTransaction()
        realm.addObject(fire)
        realm.commitWriteTransaction()
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

