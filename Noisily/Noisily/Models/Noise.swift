//
//  Noise.swift
//  Noisily
//
//  Created by Adam Ahrens on 3/11/15.
//  Copyright (c) 2015 Appsbyahrens. All rights reserved.
//

import UIKit
import Realm

class Noise: RLMObject {
    dynamic var name = ""
    dynamic var imageName = ""
    dynamic var fileName = ""
    dynamic var fileType = ""
    
    func soundFilePath() -> NSURL {
        return NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(fileName, ofType: fileType)!)!
    }
}
