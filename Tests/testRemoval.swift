//
//  testRemoval.swift
//  Tests
//
//  Created by Julian Porter on 01/03/2020.
//  Copyright © 2020 JP Embedded Solutions. All rights reserved.
//

import Foundation

import XCTest
@testable import SwiftOrderedDictionary

class TestRemoval : DictBase {
    
    func testRemoveAll() {
        testName="Test removing all from initialised dictionary"
        multiTest { size in
            _ = fillKeys(nKeys: 2*size, min: 0, max: size)
            let sz = d.keys.count
            d.removeAll()
            emit("Loaded \(sz) entries; \(d.count) after remove all")
            return d.isEmpty
        }
    }
    
    func testRemoveSeveral() {
        testName="Test removing specified keys from an initialised dictionary"
        multiTest { size in
            var itList = fillDict(nKeys: 2*size, min: 0, max: size)
            (0..<(size/4)).forEach { idx in
                let uidx : UInt = numericCast(idx)
                d.removeValue(forKey: uidx)
                itList.removeAll(where: { $0.key == uidx })
            }
            let it = d.map { $0 }
            let matched = zip(itList,it).map { $0.0 == $0.1 }
            let good = matched.filter { $0 }.count
            emit("Removed \(size/4) keys; succeded in \(good) out of \(matched.count) matches")
            return good == matched.count
        }
    }
}
