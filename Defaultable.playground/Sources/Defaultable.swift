import Foundation

/// A type that is able to fallback to a default value when it is created with `nil`
/// The `DefaultValue` is enforced by the type system
@propertyWrapper
public struct Defaultable<T, Default: DefaultValue> where Default.ValueType == T {
    public var wrappedValue: T

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
    public init(value: T?) {
        self.wrappedValue = value ?? Default.default
    }
}

extension Defaultable: CustomStringConvertible {
    public var description: String {
        return String(describing: wrappedValue)
    }
}

extension Defaultable: Equatable where T: Equatable { }
extension Defaultable: Hashable where T: Hashable { }
