//
//  HexColors.swift
//  Noisily
//
//  Created by Adam Ahrens on 3/4/15.
//  Copyright (c) 2015 Appsbyahrens. All rights reserved.
//

import UIKit

extension UIColor {
    
    // Takes a hexCode Int and converts it to RGB
    convenience init(hexCode: Int) {
        let red = Double((hexCode >> 16) & 0xff)
        let green = Double((hexCode >> 8) & 0xff)
        let blue = Double(hexCode & 0xff)
        self.init(red: CGFloat(red / 255.0), green: CGFloat(green / 255.0), blue: CGFloat(blue / 255.0), alpha: 1.0)
    }
    
    // Rich, elegant, refined, tasty, expensive
    class func deepRed() -> UIColor {
        return UIColor(hexCode: 0xa6093d)
    }
    
    // Natural, fertile, healthy, balance, life
    class func foliageGreen() -> UIColor {
        return UIColor(hexCode: 0x046a38)
    }
    
    // Exciting, playful, attention-getting, wild
    class func brightPink() -> UIColor {
        return UIColor(hexCode: 0xe0457b)
    }
    
    // Refreshing, cleansing, cool, dreamy
    class func aqua() -> UIColor {
        return UIColor(hexCode: 0xa1d6ca)
    }
    
    // Nurturing, fuzzy, tactile, inviting
    class func peach() -> UIColor {
        return UIColor(hexCode: 0xffbe9f)
    }
    
    // Calm, quiet, patient, peaceful
    class func lightBlue() -> UIColor {
        return UIColor(hexCode: 0x92c1e9)
    }
    
    // Nourishing, buttery, hospitable, comfort
    class func goldenYellow() -> UIColor {
        return UIColor(hexCode: 0xf2a900)
    }
    
    // Steadfast, responsible, conscientious, professional
    class func charcoalGray() -> UIColor {
        return UIColor(hexCode: 0x54585a)
    }
    
    // Calm, soothing, neutral, lightweight
    class func lightGreen() -> UIColor {
        return UIColor(hexCode: 0xaddc91)
    }
    
    // Contemplative, meditative, soul-searching, intuitive
    class func bluePurple() -> UIColor {
        return UIColor(hexCode: 0x5f259f)
    }
}
