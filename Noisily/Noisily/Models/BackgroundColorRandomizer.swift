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
    
    private var currentColor: UIColor?
    
    /**
     Selects a random UIColor for a list of psychology approved colors
    
     :returns: Random UIColor
    */
    func randomBackgroundColor() -> UIColor {
        var colors = self.colors
        for index in 0..<(colors.count - 1) {
            let randomIndex = Int(arc4random_uniform(UInt32(colors.count - index))) + index
            let firstColor = colors[index]
            colors[index] = colors[randomIndex]
            colors[randomIndex] = firstColor
        }
        
        var color = colors.first!
        if let currentColor = currentColor {
            if currentColor == color {
                color = colors[1]
            }
        } else {
            currentColor = color
        }
        
        return color
    }
}
