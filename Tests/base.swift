//
//  base.swift
//  Tests
//
//  Created by Julian Porter on 01/03/2020.
//  Copyright © 2020 JP Embedded Solutions. All rights reserved.
//

import XCTest

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

class TestBase : XCTestCase {
    public let rng = Randomise()
    private var lines : [String] = []
    public var testName : String? = nil {
        didSet { if let n=testName { self.emit(n) } }
    }
    
    public override func setUp() {
        lines.removeAll()
        testName = nil
    }
    
    
    
    public func emit(_ string : String) {
        lines.append(string)
        print(">>    \(string)")
    }
    public func emit(format: String,_ arguments: CVarArg...) {
        self.emit(String(format: format, arguments))
    }
    
    public func attach() {
        let text=lines.joined(separator: "\n")
        let attachment = XCTAttachment(string: text)
        attachment.lifetime = .keepAlways
        attachment.name=testName
        add(attachment)
    }
    
    func complete(good : Int,total : Int) {
        emit("\(good) out of \(total) tests succeeded")
        self.attach()
        XCTAssert(good==total)
    }
    func complete(ok : Bool) {
        self.attach()
        XCTAssert(ok)
    }
    
}
