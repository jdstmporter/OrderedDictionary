//
//  Tests.swift
//  Tests
//
//  Created by Julian Porter on 29/02/2020.
//  Copyright © 2020 JP Embedded Solutions. All rights reserved.
//

import XCTest
@testable import OrderedDictionary

class Randomise {
    
    public enum Alphabet : String {
        case Alpha = "abcdefghijklmnopqestuvwxyz"
        case Numeric = "0123456789"
        case Alphanumeric = "ancdefghijklmnopqrstuvwxyz0123456789"
    
        var count : Int { self.rawValue.count }
        subscript(_ n : UInt) -> String? {
            let nsr = NSRange(location: numericCast(n), length: 1)
            guard let r = Range<String.Index>(nsr, in: rawValue) else { return nil }
            return String(rawValue[r])
        }
        func make(_ a : [UInt]) -> String { a.compactMap { self[$0] }.joined(separator: "") }
    }
    private var rng : SystemRandomNumberGenerator
    
    public init() {
        rng = SystemRandomNumberGenerator()
    }
    
    func random<I>(min : I = 0, max : I = I.max) -> I where I : FixedWidthInteger, I : UnsignedInteger {
        I.random(in: ClosedRange<I>(uncheckedBounds: (min,max)), using: &rng)
    }
    
    func random(min : Float = 0.0, max : Float = Float.greatestFiniteMagnitude) -> Float {
        Float.random(in: Range(uncheckedBounds: (min,max)), using: &rng)
    }
    
    func bernoulli() -> Float { random(max: 1.0) }
    func boolean(p0 : Float = 0.5) -> Bool { bernoulli()>p0 }
    func byte() -> UInt8 { random(max: 255) }
    
    func array<I>(_ count : UInt,min : I = 0, max : I = I.max) -> [I] where I : FixedWidthInteger, I : UnsignedInteger {
        return (0..<count).map { _ in random(min: min,max : max) }
    }
    func bytes(_ count : UInt) -> [UInt8] { array(count, min: 0, max: 255) }
    func data(_ count : UInt) -> Data { Data(bytes(count)) }
    
    func string(_ count : UInt, alphabet : Alphabet = .Alphanumeric) -> String {
        let a : [UInt] = self.array(count, min: 0,max: numericCast(alphabet.count))
        return alphabet.make(a)
    }
    func hex(_ count : UInt) -> String { bytes(count).map { String(format: "%02x", $0) }.joined(separator: "") }
}

class Tests: XCTestCase {
    
    private var rng = Randomise()
    private var d = OrderedDictionary<UInt,String>()
    
    private let N : UInt = 100
    private let NN : [UInt] = [10,100,500,1000]
    
   
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        d.removeAll()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func handleResults(good : Int,total : Int) {
        let attachment = XCTAttachment(string: "\(good) out of \(total) tests succeeded")
        attachment.lifetime = .keepAlways
        add(attachment)
        XCTAssert(good==total)
    }

    func testAddDistinctKeysCount() {
        // test loading a fixed number of distinct keys

        let counts : [Bool] = NN.map { size in
            (0..<size).forEach { d[numericCast($0)] = rng.string(10) }
            return numericCast(d.count)==size
        }
        let good = counts.filter { $0 }.count
        handleResults(good: good,total: NN.count)
    }
    
    func testAddNonDistinctKeysCount() {
        let keys : [UInt] = rng.array(2*N, min: 0, max: N)
        keys.forEach { d[$0] = rng.string(10) }
        print("Count is \(d.count), added \(Set(keys).count)")
        XCTAssertEqual(d.count, Set(keys).count)
    }
    
    func testAddDistinctKeysValues() {
        // test loading a fixed number of distinct keys
        let keys : [UInt] = (0..<N).map { $0 }
        keys.forEach { d[$0] = rng.string(10) }
        XCTAssertEqual(d.keys,keys)
    }
    
    func testAddNonDistinctKeysValues() {
        let keys : [UInt] = rng.array(2*N, min: 0, max: N)
        keys.forEach { d[$0] = rng.string(10) }

        XCTAssertEqual(Set(d.keys), Set(keys))
    }

    

}
