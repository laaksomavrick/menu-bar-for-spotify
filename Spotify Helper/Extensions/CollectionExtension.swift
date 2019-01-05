//
//  Collection.swift
//  Spotify Helper
//
//  Created by Mavrick Laakso on 2017-10-22.
//  Copyright © 2017 Mavrick Laakso. All rights reserved.
//
//  Convenience collections functions - i wanted safe array access

import Foundation

// dt: can add new functionality on types ad hoc (dsls)
extension Collection {
    
    // dt: defining a new operator
    // Returns the element at the specified index iff it is within bounds, otherwise nil.
    // https://stackoverflow.com/questions/25329186/safe-bounds-checked-array-lookup-in-swift-through-optional-bindings
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}
