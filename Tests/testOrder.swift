//
//  Tests.swift
//  Tests
//
//  Created by Julian Porter on 29/02/2020.
//  Copyright © 2020 JP Embedded Solutions. All rights reserved.
//

import XCTest
@testable import SwiftOrderedDictionary


class TestOrder: DictBase {

    func testAddDistinctKeysCount() {
        // test loading a fixed number of distinct keys
        testName = "Add specified number of distinct keys; check count"
        multiTest { size in
            (0..<size).forEach { d[numericCast($0)] = rng.string(10) }
            return numericCast(d.count)==size
        }
    }
    
    func testAddNonDistinctKeysCount() {
        testName = "Add specified number of non-distinct keys; check count"
        multiTest { size in
            let keys = fillKeys(nKeys: 2*size, min: 0, max: size)
            emit("Count is \(d.keys.count), added \(keys.count)")
            return d.keys.count == keys.count
        }
    }
    
    func testAddDistinctKeysValues() {
        testName = "Add specified number of distinct keys; check ordered key array"
        // test loading a fixed number of distinct keys
        multiTest { size in
            let keys : [UInt] = (0..<size).map { $0 }
            keys.forEach { d[$0] = rng.string(10) }
            return d.keys == keys
        }
    }
    
    func testOrderAddNonDistinctKeys() {
        testName = "Add specified number of non-distinct keys; check ordered key array"
        multiTest { size in
            let keys = fillKeys(nKeys: 2*size, min: 0, max: size)
            return d.keys == keys
        }
    }
    
    func testOrderAddNonDistinctValues() {
        testName = "Add specified number of non-distinct keys; check ordered value array"
        multiTest { size in
            let itVals = fillDict(nKeys: 2*size, min: 0, max: size)
            let dvals = itVals.map { $0.value }
            return d.values == dvals
        }
    }

    

}
