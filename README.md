# SwiftOrdered Dictionary


[![CI Status](https://img.shields.io/travis/jdstmporter/SwiftOrderedDictionary.svg?style=flat)](https://travis-ci.org/jdstmporter/SwiftOrderedDictionary)
[![Version](https://img.shields.io/cocoapods/v/SwiftOrderedDictionary.svg?style=flat)](https://cocoapods.org/pods/SwiftOrderedDictionary)
[![License](https://img.shields.io/cocoapods/l/SwiftOrderedDictionary.svg?style=flat)](https://cocoapods.org/pods/SwiftOrderedDictionary)
[![Platform](https://img.shields.io/cocoapods/p/SwiftOrderedDictionary.svg?style=flat)](https://cocoapods.org/pods/SwiftOrderedDictionary)

## API

SwiftOrderedDictionary offers a native Swift lightweight wrapper `OrderedDictionary` around the build in Swift `Dictionary` class, adding to it the capability to remember the order in which its key were first added.  

The API for `OrderedDictionary` is essentially the same as that of `Dictionary`, so it should, in most cases, function as a simple drop-in replacement.  The differences are that:

* Variables like `keys` and `values` are now ordered, so they can be implemented as Arrays.  This means that `OrderedDictionary<K,V>.Keys == Array<K>` and  `OrderedDictionary<K,V>.Values == Array<V>`;, so there is no need to cast them to type `Array` as would be the case wityh an unordered dictionary.
* Methods on `Dictionary` that do not work in an ordered context are dropped.  Specifically, this means methods ands constructors that use a uniquing function.  In particular, there are no `merge` methods.  

The outline API of the type, written as a pseudo-protocol, is as follows.  Methods perform as in a normal dictionary unless otherwise specified:

```swift
class OrderedDictionary<K,V> : Sequence where K : Hashable {
    
    typealias Element = (key: K,value : V)
    typealias Iterator = Array<Element>.Iterator
    typealias Keys = Array<K>
    typealias Values = Array<V>
    
    init() 
    init(minimumCapacity: Int) 
    init<S>(uniqueKeysWithValues: S) where S: Sequence, S.Element == (K,V) 
    
    var count : Int { get }
    var underestimatedCount: Int { get }
    var isEmpty : Bool { get }
    var capacity : Int { get }
    func reserveCapacity(_ : Int) 
    
    subscript( _ key : K) -> V? { get, set }
    subscript(_ key : K,default d: @autoclosure () -> V) -> V { get }
    
    var first : Element? { get }
    var randomElement : Element? { get }
    func randomElement<T>(using _: inout T) -> Element? where T : RandomNumberGenerator 
    
    var keys : Keys { get }
    var values : Values { get }
    
    /// method not in ordinary dictionary - returns key/value pairs as an ordered list
    var asArray : [Element] { get } 
    
    func updateValue(_ : V,forKey: K) -> V? )
    
    func removeAll() 
    public func removeValue(forKey : K) -> V? 
    
    // method not in ordinary dictionary - can now answer the question precisely by checking the list
    // of keys
    public func contains(_ : K) -> Bool 
    
}
```



## Installation

ColourWheel is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'OrderedDictionary'
```

## Author

jdstmporter, julian@porternet.org.uk.  
