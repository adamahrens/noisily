//
//  NoiseSelectionViewController.swift
//  Noisily
//
//  Created by Adam Ahrens on 3/4/15.
//  Copyright (c) 2015 Appsbyahrens. All rights reserved.
//

import UIKit

class NoiseSelectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let backgroundRandomizer = BackgroundColorRandomizer()
    private let noises = Noise.allObjects()
    
    private var timer : NSTimer? = nil
    private var cellWidth = 0.0
    private var cellHeight = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = backgroundRandomizer.randomBackgroundColor()
        
        // Configure the collectionViewCellSize
        configureCellSizeForCurrentTraitCollection()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        timer = NSTimer.scheduledTimerWithTimeInterval(70.0, target: self, selector: "changeBackgroundColor", userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        timer!.invalidate()
        timer = nil
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
    
    //MARK: UICollectionViewDatasource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(noises.count)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("NoiseCollectionViewCell", forIndexPath: indexPath) as NoiseCollectionViewCell
        let noise = noises[UInt(indexPath.row)] as Noise
        cell.imageView.image = UIImage(named: noise.imageName)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        configureCellSizeForCurrentTraitCollection()
    }
    
    //MARK: Private
    private func configureCellSizeForCurrentTraitCollection() {
        // iPhone 4, 5, 6 in Landscape
        if self.traitCollection.horizontalSizeClass == .Compact && self.traitCollection.verticalSizeClass == .Compact {
            cellWidth = 120.0
            cellHeight = 130.0
        }
        
        // iPhone 6+ in Landscape
        if self.traitCollection.horizontalSizeClass == .Regular && self.traitCollection.verticalSizeClass == .Compact {
            cellWidth = 160.0
            cellHeight = 180.0
        }
        
        // iPhone's in portrait
        if self.traitCollection.horizontalSizeClass == .Compact && self.traitCollection.verticalSizeClass == .Regular {
            cellWidth = 120.0
            cellHeight = 150.0
        }
        
        // iPad Portrait or Landscape
        // Check if pad. Could eventually have a phone that's Regular
        // in Vertical & Horizontal size class
        if self.traitCollection.userInterfaceIdiom == .Pad &&  self.traitCollection.horizontalSizeClass == .Regular && self.traitCollection.verticalSizeClass == .Regular {
            cellWidth = 300.0
            cellHeight = 300.0
        }
        
        self.collectionView.reloadData()
    }
}
