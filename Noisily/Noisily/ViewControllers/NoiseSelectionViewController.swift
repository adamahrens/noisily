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
    private let dataSource = NoiseDataSource()
    
    private var timer : NSTimer?
    private var cellWidth = 0.0
    private var cellHeight = 0.0
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor! = UIColor.clearColor()
        self.view.backgroundColor = backgroundRandomizer.randomBackgroundColor()
        configureCellSizeForCurrentTraitCollection(self.traitCollection)
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
    
//    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
//    }
    
    //MARK: TraitCollection
    override func willTransitionToTraitCollection(newCollection: UITraitCollection, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransitionToTraitCollection(newCollection, withTransitionCoordinator: coordinator)
        
        // Animate the reloading of the collectionView
        configureCellSizeForCurrentTraitCollection(newCollection)
        coordinator.animateAlongsideTransition({context in self.collectionView.reloadData()}, completion: nil)
    }

    //MARK: NSTimer Selector
    func changeBackgroundColor() {
        let newBackgroundColor = backgroundRandomizer.randomBackgroundColor()
        var animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.fromValue = self.view.backgroundColor?.CGColor
        animation.toValue = newBackgroundColor.CGColor
        animation.duration = 10
        self.view.layer.addAnimation(animation, forKey: "fadeAnimation")
        self.view.backgroundColor = newBackgroundColor
    }
    
    //MARK: UICollectionView Datasource & Delegate
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return dataSource.numberOfSections()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Adding extra for plus
        return dataSource.numberOfNoises() + 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("NoiseCollectionViewCell", forIndexPath: indexPath) as! NoiseCollectionViewCell
        cell.backgroundColor! = UIColor.clearColor()
        if indexPath.row == dataSource.numberOfNoises() {
            cell.imageView.image = UIImage(named: "Plus")
            cell.volumeSlider.hidden = true
        } else {
            let noise = dataSource.noiseAtIndexPath(indexPath)
            cell.imageView.image = UIImage(named: noise.imageName)
            cell.volumeSlider.value = Float(dataSource.currentVolumeForNoise(noise))
            cell.volumeSlider.addTarget(self, action: "volumeSliderChanged:", forControlEvents: .ValueChanged)
            cell.volumeSlider.tag = indexPath.row
            cell.volumeSlider.hidden = !dataSource.noiseIsPlaying(indexPath)
        }
       
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == dataSource.numberOfNoises() {
            self.performSegueWithIdentifier("ShowLayeringViewController", sender: nil)
        } else {
            dataSource.toggleNoiseAtIndexPath(indexPath)
            collectionView.reloadItemsAtIndexPaths([indexPath])
        }
    }
    
    //MARK: Volume Changes
    func volumeSliderChanged(slider: UISlider) {
        let noise = dataSource.noiseAtIndexPath(NSIndexPath(forRow: slider.tag, inSection: 0))
        dataSource.updateVolumeForNoise(noise, volume: Double(slider.value))
    }
    
    //MARK: Private
    private func configureCellSizeForCurrentTraitCollection(traitCollection: UITraitCollection) {
        // iPhone 4, 5, 6 in Landscape
        if traitCollection.horizontalSizeClass == .Compact && traitCollection.verticalSizeClass == .Compact {
            cellWidth = 120.0
            cellHeight = 130.0
        }
        
        // iPhone 6+ in Landscape
        if traitCollection.horizontalSizeClass == .Regular && traitCollection.verticalSizeClass == .Compact {
            cellWidth = 160.0
            cellHeight = 180.0
        }
        
        // iPhone's in portrait
        if traitCollection.horizontalSizeClass == .Compact && traitCollection.verticalSizeClass == .Regular {
            cellWidth = 120.0
            cellHeight = 150.0
        }
        
        // iPad Portrait or Landscape
        // Check if pad. Could eventually have a phone that's Regular
        // in Vertical & Horizontal size class
        if traitCollection.userInterfaceIdiom == .Pad && traitCollection.horizontalSizeClass == .Regular && traitCollection.verticalSizeClass == .Regular {
            cellWidth = 300.0
            cellHeight = 300.0
        }
    }
}
