//
//  UIColorExtensionTests.swift
//  Noisily
//
//  Created by Adam Ahrens on 3/4/15.
//  Copyright (c) 2015 Appsbyahrens. All rights reserved.
//

import UIKit
import XCTest

class UIColorExtensionTests: XCTestCase {
    
    func testDeepRed() {
        let deepRed = UIColor.deepRed()
        XCTAssertEqual(deepRed, UIColor(red: 166/255.0, green: 9/255.0, blue: 61/255.0, alpha: 1), "Deep red should have the right rgb")
    }
}
