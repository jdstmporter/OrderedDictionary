//
//  dictBase.swift
//  Tests
//
//  Created by Julian Porter on 01/03/2020.
//  Copyright © 2020 JP Embedded Solutions. All rights reserved.
//

import XCTest
@testable import SwiftOrderedDictionary

class DictBase : TestBase {
    internal var d = OrderedDictionary<UInt,String>()
    
    public let N : UInt = 100
    public let NN : [UInt] = [10,100,500,1000]
    
    
    override func setUp() {
        super.setUp()
        d.removeAll()
    }
    
    internal func multiTest(action: (UInt) -> Bool) {
        let counts : [Bool] = NN.map { size in
            d.removeAll()
            return action(size)
        }
        let good = counts.filter { $0 }.count
        complete(good: good,total: NN.count)
    }
    
    internal func fillKeys(nKeys: UInt, min: UInt = 0, max: UInt = 1000) -> [UInt] {
        let keys : [UInt] = rng.array(nKeys, min: min, max: max)
        var dkeys : [UInt] = []
        keys.forEach { key in
            d[key] = rng.string(10)
            if !dkeys.contains(key) { dkeys.append(key) }
        }
        return dkeys
    }
    
    internal func fillDict(nKeys: UInt, min: UInt = 0, max: UInt = 1000) -> [Pair<UInt,String>] {
        let keys : [UInt] = rng.array(nKeys, min: min, max: max)
        var dkeys : [UInt] = []
        var dvals : [String] = []
        keys.forEach { key in
            let s=rng.string(10)
            d[key] = s
            if let idx = dkeys.firstIndex(of: key) {
                dvals[idx]=s
            }
            else {
                dkeys.append(key)
                dvals.append(s)
            }
        }
        return zip(dkeys, dvals).map { Pair($0) }
    }
}

