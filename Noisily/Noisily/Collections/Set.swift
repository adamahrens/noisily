//
//  Set.swift
//  Noisily
//
//  Created by Adam Ahrens on 3/23/15.
//  Copyright (c) 2015 Appsbyahrens. All rights reserved.
//

import Foundation

class Set<T: Equatable> {
    private var elements = [T]()
    
    /**
    Adds the element if it's not already contained
    
    :param: element Element to add if it's not already added
    */
    func add(element: T) {
        if contains(element) {
            return
        }
        
        elements.append(element)
    }
    
    /**
    Removes the element if it's present
    
    :param: element Element to remove if it's present
    */
    func remove(element: T) {
        if !contains(element) {
            return
        }
        
        elements = elements.filter { $0 != element }
    }
    
    /**
    Returns the number of elements in the Set

    :returns: number of elements, 0 if empty
    */
    func size() -> Int {
        return elements.count
    }
    
    /**
    Checks if an element is contained in the set
    
    :param: element Element to check if it's contained in the Set
    :returns: true if in the Set, false otherwise
    */
    func contains(element: T) -> Bool {
        return elements.filter { $0 == element }.count == 1
    }
    
    /**
    Clears all the elements in the set
    */
    func clear() {
        elements = [T]()
    }
}
