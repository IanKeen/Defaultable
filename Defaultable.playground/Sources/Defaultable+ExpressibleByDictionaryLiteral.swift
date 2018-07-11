import Foundation

public protocol DictionaryConvertible {
    associatedtype Key
    associatedtype Value
    
    init(items: [(Key, Value)])
}
extension Dictionary: DictionaryConvertible {
    public init(items: [(Key, Value)]) {
        self.init(uniqueKeysWithValues: items)
    }
}
extension Defaultable: ExpressibleByDictionaryLiteral where T: DictionaryConvertible {
    public typealias Key = T.Key
    public typealias Value = T.Value
    
    public init(dictionaryLiteral elements: (Key, Value)...) {
        self.init(value: T.init(items: elements))
    }
}
