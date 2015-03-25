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
    
    // Currently displayed sectors
    private var currentSectors = Array<Dictionary<String,SAMultisectorSector>>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            let noiseName = dataSource.noiseAtIndexPath(indexPath).name
            selectedPaths.remove(indexPath)
            let found = currentSectors.filter { $0.keys.first! == noiseName }
            if let dictionary = found.first {
                let sectorToRemove = dictionary.values.first!
                multiSectorControl.removeSector(sectorToRemove)
                currentSectors = currentSectors.filter{ $0.keys.first! != noiseName }
            }
        } else {
            // Add a sector
            selectedPaths.add(indexPath)
            let color = selectedPaths.size() % 2 == 0 ? UIColor.whiteColor() : UIColor.brightPink()
            let sector = SAMultisectorSector(color: color, minValue: 1.0, maxValue: 20.0)
            let noiseName = dataSource.noiseAtIndexPath(indexPath).name
            sector.tag = selectedPaths.size()
            multiSectorControl.addSector(sector)
            multiSectorControl.setNeedsDisplay()
            currentSectors.append([noiseName: sector])
        }
        
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
}
