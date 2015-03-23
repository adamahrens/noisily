//
//  SetTests.swift
//  Noisily
//
//  Created by Adam Ahrens on 3/23/15.
//  Copyright (c) 2015 Appsbyahrens. All rights reserved.
//

import XCTest

class SetTests: XCTestCase {
    
    private var setIndexPaths = Set<NSIndexPath>()
    
    override func setUp() {
        super.setUp()
        setIndexPaths = Set<NSIndexPath>()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        setIndexPaths.clear()
    }

    func testSizeOfSet() {
        XCTAssert(setIndexPaths.size() == 0, "Empty Set should have no elements")
        
        // Adding should increse the size
        setIndexPaths.add(NSIndexPath(forRow: 0, inSection: 0))
        
        // Should have 1 element
        XCTAssert(setIndexPaths.size() == 1, "Adding should increase number of elements by 1")
    }
    
    func testAddingElementsToSet() {
        setIndexPaths.add(NSIndexPath(forRow: 0, inSection: 0))
        
        // Set should contain the new element
        let contains = setIndexPaths.contains(NSIndexPath(forRow: 0, inSection: 0))
        XCTAssert(contains, "Set should now contain the NSIndexPath we added")
        
        // Adding the same element should change the size
        setIndexPaths.add(NSIndexPath(forRow: 0, inSection: 0))
        
        XCTAssert(setIndexPaths.size() == 1, "Adding duplicates shouldn't increase size")
    }
    
    func testClearingRemovesAllElements() {
        setIndexPaths.add(NSIndexPath(forRow: 0, inSection: 0))
        setIndexPaths.add(NSIndexPath(forRow: 0, inSection: 1))
        setIndexPaths.clear()
        
        XCTAssert(setIndexPaths.size() == 0, "Clearing Should Remove All Elements")
        
        // Verify we can add back a previous NSIndexPath that we removed
        setIndexPaths.add(NSIndexPath(forRow: 0, inSection: 0))
        let contains = setIndexPaths.contains(NSIndexPath(forRow: 0, inSection: 0))
        XCTAssert(contains, "Set should now contain the NSIndexPath we added back")
    }
    
    func testRemovingElementsFromSet() {
        setIndexPaths.add(NSIndexPath(forRow: 0, inSection: 0))
        setIndexPaths.add(NSIndexPath(forRow: 0, inSection: 1))
        
        // Remove element that doesn't exist
        let sizeBeforeRemove = setIndexPaths.size()
        setIndexPaths.remove(NSIndexPath(forRow: 1, inSection: 1))
        let sizeAfterRemove = setIndexPaths.size()
        XCTAssert(sizeBeforeRemove == sizeAfterRemove, "Removing element not present has no effect")
        
        // Ensure we can remove an exisiting element
        setIndexPaths.remove(NSIndexPath(forRow: 0, inSection: 1))
        XCTAssert(setIndexPaths.size() == 1, "Can remove an exisiting item")
        XCTAssertFalse(setIndexPaths.contains(NSIndexPath(forRow: 0, inSection: 1)), "Removed item no longer in the set")
    }
}
