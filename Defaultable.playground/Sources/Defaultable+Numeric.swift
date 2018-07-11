import Foundation

extension Defaultable: Numeric where T: Numeric {
    public typealias Magnitude = T.Magnitude
    
    public init?<U: BinaryInteger>(exactly source: U) {
        self.init(value: T.init(exactly: source))
    }
    
    public var magnitude: Magnitude {
        return value.magnitude
    }
    
    public static func +(lhs: Defaultable, rhs: Defaultable) -> Defaultable {
        return self.init(value: lhs.value + rhs.value)
    }
    
    public static func +=(lhs: inout Defaultable, rhs: Defaultable) {
        lhs.value += rhs.value
    }
    
    public static func *(lhs: Defaultable, rhs: Defaultable) -> Defaultable {
        return self.init(value: lhs.value * rhs.value)
    }
    
    public static func *=(lhs: inout Defaultable, rhs: Defaultable) {
        lhs.value *= rhs.value
    }
    
    public static func -(lhs: Defaultable, rhs: Defaultable) -> Defaultable {
        return self.init(value: lhs.value - rhs.value)
    }
    
    public static func -=(lhs: inout Defaultable, rhs: Defaultable) {
        lhs.value -= rhs.value
    }
}

extension Defaultable: SignedNumeric where T: SignedNumeric { }
