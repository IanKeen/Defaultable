import Foundation

/// A type that is able to provide a default value
public protocol DefaultValue {
    associatedtype ValueType
    static var `default`: ValueType { get }
}

public struct True: DefaultValue {
    public static var `default`: Bool { return true }
}
public struct False: DefaultValue {
    public static var `default`: Bool { return false }
}
public struct EmptyString: DefaultValue {
    public static var `default`: String { return "" }
}
public struct EmptyArray<S: Sequence>: DefaultValue {
    public static var `default`: [S.Element] { return [] }
}
public struct EmptyDictionary<K: Hashable, V>: DefaultValue {
    public static var `default`: [K: V] { return [:] }
}
public struct Zero<N: Numeric>: DefaultValue {
    public static var `default`: N { return 0 }
}
