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

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.charcoalGray()
        
        // Add a sector
        let sector = SAMultisectorSector(color: UIColor.deepRed(), minValue: 1.0, maxValue: 100.0)
        sector.tag = 1
        
        let sector2 = SAMultisectorSector(color: UIColor.brightPink(), minValue: 1.0, maxValue: 100.0)
        sector.tag = 2
        
        let sector3 = SAMultisectorSector(color: UIColor.whiteColor(), minValue: 1.0, maxValue: 100.0)
        sector.tag = 3
        
        // Add it to the control
        multiSectorControl.addSector(sector)
        multiSectorControl.addSector(sector2)
        multiSectorControl.addSector(sector3)
    }
}
