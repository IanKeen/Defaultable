import Foundation

/// A type that is able to fallback to a default value when it is created with `nil`
/// The `DefaultValue` is enforced by the type system
public struct Defaultable<T, Default: DefaultValue> where Default.ValueType == T {
    public var value: T
    
    public init(value: T?) {
        self.value = value ?? Default.default
    }
}

extension Defaultable: CustomStringConvertible {
    public var description: String {
        switch value {
        case let value as CustomStringConvertible:
            return value.description
        default:
            return "\(value)"
        }
    }
}

extension Defaultable: Equatable where T: Equatable {
    public static func ==(lhs: Defaultable, rhs: Defaultable) -> Bool {
        return lhs.value == rhs.value
    }
    public static func ==<V>(lhs: Defaultable<T, V>, rhs: T) -> Bool {
        return lhs.value == rhs
    }
    public static func ==<V>(lhs: T, rhs: Defaultable<T, V>) -> Bool {
        return lhs == rhs.value
    }
}
extension Defaultable where T: Equatable {
    public static func ==<OtherDefault>(lhs: Defaultable<T, Default>, rhs: Defaultable<T, OtherDefault>) -> Bool {
        return lhs.value == rhs.value
    }
}

extension Defaultable: Hashable where T: Hashable {
    public var hashValue: Int {
        return value.hashValue
    }
}
