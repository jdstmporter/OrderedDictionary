//
//  testIterator.swift
//  Tests
//
//  Created by Julian Porter on 01/03/2020.
//  Copyright © 2020 JP Embedded Solutions. All rights reserved.
//

import XCTest
@testable import SwiftOrderedDictionary

class TestIterator : DictBase {

    func testIteration() {
        testName = "Initialise the dictionary; check the result of iterating over it"
        multiTest { size in
            let itList = fillDict(nKeys: 2*size, min: 0, max: size)
            let it = d.map { $0 }
            let matched = zip(itList,it).map { $0.0 == $0.1 }
            let good = matched.filter { $0 }.count
            emit("Succeded in \(good) out of \(matched.count) matches")
            return good == matched.count
        }
    }
    
}
