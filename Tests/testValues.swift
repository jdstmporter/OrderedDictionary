//
//  testValues.swift
//  Tests
//
//  Created by Julian Porter on 01/03/2020.
//  Copyright © 2020 JP Embedded Solutions. All rights reserved.
//

import XCTest
@testable import SwiftOrderedDictionary

class TestValues : DictBase {
    
    private func checkDict(_ size : UInt) -> ([UInt],[UInt:String]){
        let keys : [UInt] = rng.array(2*size, min: 0, max: size)
        var dict : [UInt:String] = [:]
        
        keys.forEach { key in
            let s=rng.string(10)
            d[key] = s
            dict[key] = s
        }
        return(keys,dict)
    }
    
    func testValueSet() {
        testName = "Add number of values with non-distinct keys; check unordered value set"
        multiTest { size in
            let (keys,dict) = checkDict(size)
            emit("Count is \(d.keys.count), added \(Set(keys).count)")
            return Set(d.values)==Set(dict.values)
        }
        
    }
    
    func testPutAndGet() {
        testName = "Initialise with non-distinct keys; check random access to content"
        multiTest { size in
            let (keys,dict) = checkDict(size)
            let matched : [Bool] = (0..<(3*size)).compactMap { _ in
                guard let k = keys.randomElement() else { return nil }
                return dict[k] == d[k]
            }
            let good = matched.filter { $0 }.count
            emit("Succeded in \(good) out of \(matched.count) trials")
            return good==matched.count
        }
    }
    
}
