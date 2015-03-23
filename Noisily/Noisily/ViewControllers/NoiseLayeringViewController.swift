//
//  NoiseLayeringViewController.swift
//  Noisily
//
//  Created by Adam Ahrens on 3/19/15.
//  Copyright (c) 2015 Appsbyahrens. All rights reserved.
//

import UIKit

class NoiseLayeringViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var multiSectorControl: SAMultisectorControl!
    
    private let dataSource = NoiseDataSource()
    private let selectedPaths = Set<NSIndexPath>()
    
    // Used for how many noises we can layer together
    private var maxSectors = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Determine max number of noises
        // that can be selected
        determineMaxNumberOfSelections()
        
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
        //multiSectorControl.addSector(sector4)
        
        // Blur the background
        let blurEffect = UIBlurEffect(style: .Light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.insertSubview(blurView, atIndex: 0)
        
        // Have equal width and height
        var equalHeight = NSLayoutConstraint(item: blurView, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 1.0, constant: 0.0)
        var equalWidth = NSLayoutConstraint(item: blurView, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 1.0, constant: 0.0)
        self.view.addConstraints([equalHeight, equalWidth])

        // Want white checkmarks for UItableViewCells
        UITableViewCell.appearance().tintColor = UIColor.whiteColor()
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
    
    //MARK: UITableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataSource.numberOfSections()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfNoises()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NoiseCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = dataSource.noiseAtIndexPath(indexPath).name
        cell.textLabel!.textColor = UIColor.whiteColor()
        
        if selectedPaths.contains(indexPath) {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if selectedPaths.contains(indexPath) {
            selectedPaths.remove(indexPath)
        } else {
            selectedPaths.add(indexPath)
        }
        
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    //MARK: Private Helpers
    private func determineMaxNumberOfSelections() {
        
    }
}
