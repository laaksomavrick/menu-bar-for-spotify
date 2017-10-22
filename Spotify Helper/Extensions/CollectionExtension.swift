//
//  Collection.swift
//  Spotify Helper
//
//  Created by Mavrick Laakso on 2017-10-22.
//  Copyright © 2017 Mavrick Laakso. All rights reserved.
//

import Foundation

extension Collection {
    
    // Returns the element at the specified index iff it is within bounds, otherwise nil.
    // https://stackoverflow.com/questions/25329186/safe-bounds-checked-array-lookup-in-swift-through-optional-bindings
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}
