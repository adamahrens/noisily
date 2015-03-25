//
//  BackgroundColorRandomizer.swift
//  Noisily
//
//  Created by Adam Ahrens on 3/4/15.
//  Copyright (c) 2015 Appsbyahrens. All rights reserved.
//

import UIKit

class BackgroundColorRandomizer: NSObject {
    private var colors: [UIColor] {
        get {
            return [UIColor.deepRed(), UIColor.foliageGreen(), UIColor.brightPink(), UIColor.aqua(), UIColor.peach(), UIColor.lightBlue(), UIColor.goldenYellow(), UIColor.charcoalGray(), UIColor.lightGreen(), UIColor.bluePurple()]
        }
    }
    
    /**
     Selects a random UIColor for a list of psychology approved colors
    
     :returns: Random UIColor
    */
    func randomBackgroundColor() -> UIColor {
        let randomIndex = Int(arc4random_uniform(UInt32(self.colors.count)))
        return self.colors.filter({ $0 == self.colors[randomIndex]}).first!
    }
}
