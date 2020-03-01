public struct Pair<K,V> {
    public let key : K
    public let value : V
    
    public init( _ kv : (K,V)) {
        self.key=kv.0
        self.value=kv.1
    }
    public init( key : K, value : V) {
        self.key=key
        self.value=value
    }
    public init(_ key : K,_ value : V) {
        self.key=key
        self.value=value
    }
}

extension Pair : Equatable where K : Equatable, V : Equatable {
    
}


public class OrderedDictionary<K,V> : Sequence where K : Hashable {
    
    public typealias Element = Pair<K,V>
    public typealias Iterator = Array<Element>.Iterator
    public typealias Keys = Array<K>
    public typealias Values = Array<V>
    
    public private(set) var keys : Keys
    private var dict : [K:V]
    
    public init() {
        keys=[]
        dict=[:]
    }
    public init(minimumCapacity: Int) {
        keys=[]
        dict=Dictionary(minimumCapacity: minimumCapacity)
    }
    public init<S>(uniqueKeysWithValues kv : S) where S: Sequence, S.Element == (K,V) {
        keys=kv.map { $0.0 }
        dict=Dictionary(uniqueKeysWithValues: kv)
    }
    
    private func make(_ key : K?) -> Element? {
        guard let k = key, let value=dict[k] else { return nil }
        return Element(key: k, value: value)
    }
    
    
    public var count : Int { keys.count }
    public var underestimatedCount: Int { keys.underestimatedCount }
    public var isEmpty : Bool { count==0 }
    public var capacity : Int { dict.capacity }
    public func reserveCapacity(_ n : Int) { dict.reserveCapacity(n) }
    
    public subscript( _ key : K) -> V? {
        get { self.dict[key] }
        set {
            guard let value = newValue else { return }
            if !keys.contains(key) { keys.append(key) }
            dict[key] = value
        }
    }
    public subscript(_ key : K,default d: @autoclosure () -> V) -> V {
        self.dict[key, default : d()]
    }
    public var first : Element? { make(keys.first) }
    public var randomElement : Element? { make(keys.randomElement()) }
    public func randomElement<T>(using rng: inout T) -> Element? where T : RandomNumberGenerator {
        make(keys.randomElement(using: &rng))
    }
    
    public __consuming func makeIterator() -> OrderedDictionary<K, V>.Iterator {
        self.asArray.makeIterator()
    }
    public var values : Values { self.map { $0.value } }
    public var asArray : [Element] {
        self.keys.compactMap { make($0) }
    }
    
    public func updateValue(_ v : V,forKey k: K) -> V? {
        let out = self[k]
        self[k]=v
        return out
    }
    
    public func removeAll(keepingCapacity k: Bool = false) {
        keys=[]
        dict.removeAll(keepingCapacity: k)
    }
    @discardableResult public func removeValue(forKey key : K) -> V? {
        guard keys.contains(key) else { return nil }
        let out = self[key]
        keys.removeAll { $0 == key }
        dict.removeValue(forKey: key)
        return out
    }
    public func contains(_ key : K) -> Bool { keys.contains(key) }
    
}






