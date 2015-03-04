//
//  NoiseSelectionViewController.swift
//  Noisily
//
//  Created by Adam Ahrens on 3/4/15.
//  Copyright (c) 2015 Appsbyahrens. All rights reserved.
//

import UIKit

class NoiseSelectionViewController: UIViewController {
    private let backgroundRandomizer = BackgroundColorRandomizer()
    private var timer : NSTimer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = backgroundRandomizer.randomBackgroundColor()
        timer = NSTimer.scheduledTimerWithTimeInterval(70.0, target: self, selector: Selector("changeBackgroundColor"), userInfo: nil, repeats: true)
    }
    
    func changeBackgroundColor() {
        let newBackgroundColor = backgroundRandomizer.randomBackgroundColor()
        var animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.fromValue = self.view.backgroundColor?.CGColor
        animation.toValue = newBackgroundColor.CGColor
        animation.duration = 10
        self.view.layer.addAnimation(animation, forKey: "fadeAnimation")
        self.view.backgroundColor = newBackgroundColor
    }
}