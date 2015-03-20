//
//  NoiseLayeringViewController.swift
//  Noisily
//
//  Created by Adam Ahrens on 3/19/15.
//  Copyright (c) 2015 Appsbyahrens. All rights reserved.
//

import UIKit

class NoiseLayeringViewController: UIViewController {

    @IBOutlet weak var multiSectorControl: SAMultisectorControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a sector
        let sector = SAMultisectorSector(color: UIColor.whiteColor(), minValue: 1.0, maxValue: 100.0)
        sector.tag = 1
        
        let sector2 = SAMultisectorSector(color: UIColor.brightPink(), minValue: 1.0, maxValue: 100.0)
        sector.tag = 2
        
        let sector3 = SAMultisectorSector(color: UIColor.whiteColor(), minValue: 1.0, maxValue: 100.0)
        sector.tag = 3
        
        let sector4 = SAMultisectorSector(color: UIColor.brightPink(), minValue: 1.0, maxValue: 100.0)
        sector.tag = 4
        
        // Add it to the control
        multiSectorControl.addSector(sector)
        multiSectorControl.addSector(sector2)
        multiSectorControl.addSector(sector3)
        multiSectorControl.addSector(sector4)
        
        // Blur the background
        let blurEffect = UIBlurEffect(style: .Light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        let vibrancyEffect = UIVibrancyEffect(forBlurEffect: blurEffect)
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        
        vibrancyView.setTranslatesAutoresizingMaskIntoConstraints(false)
        blurView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.insertSubview(blurView, atIndex: 0)
        
        multiSectorControl.addSubview(vibrancyView)
        
        // Have equal width and height
        var equalHeight = NSLayoutConstraint(item: blurView, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 1.0, constant: 0.0)
        var equalWidth = NSLayoutConstraint(item: blurView, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 1.0, constant: 0.0)
        self.view.addConstraints([equalHeight, equalWidth])
        
        equalHeight = NSLayoutConstraint(item: vibrancyView, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 1.0, constant: 0.0)
        equalWidth = NSLayoutConstraint(item: vibrancyView, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 1.0, constant: 0.0)
        self.view.addConstraints([equalHeight, equalWidth])
    }

    @IBAction func dismiss(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        self.multiSectorControl.setNeedsDisplay()
        coordinator.animateAlongsideTransition({ (coordinator) -> Void in
            self.multiSectorControl.layer.layoutIfNeeded()
        }, completion: nil)
    }
}
