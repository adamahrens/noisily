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
    
    override var hashValue: Int {
        return name.hashValue & imageName.hashValue & fileName.hashValue & fileType.hashValue
    }
    
    func soundFilePath() -> NSURL {
        return NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(fileName, ofType: fileType)!)
    }
}

func ==(lhs: Noise, rhs: Noise) -> Bool {
    let sameName = lhs.name == rhs.name
    let sameImageName = lhs.imageName == rhs.imageName
    let sameFileName = lhs.fileName == rhs.fileName
    let sameFileType = lhs.fileType == rhs.fileType
    return sameName && sameImageName && sameFileName && sameFileType
}

func !=(lhs: Noise, rhs: Noise) -> Bool {
    return !(lhs == rhs)
}
