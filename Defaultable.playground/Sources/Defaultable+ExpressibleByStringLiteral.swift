import Foundation

extension Defaultable: ExpressibleByStringLiteral where T: ExpressibleByStringLiteral {
    public typealias StringLiteralType = T.StringLiteralType
    
    public init(stringLiteral value: StringLiteralType) {
        self = .init(value: T.init(stringLiteral: value))
    }
}

extension Defaultable: ExpressibleByExtendedGraphemeClusterLiteral where T: ExpressibleByExtendedGraphemeClusterLiteral {
    public typealias ExtendedGraphemeClusterLiteralType = T.ExtendedGraphemeClusterLiteralType
    
    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self = .init(value: T.init(extendedGraphemeClusterLiteral: value))
    }
}

extension Defaultable: ExpressibleByUnicodeScalarLiteral where T: ExpressibleByUnicodeScalarLiteral {
    public typealias UnicodeScalarLiteralType = T.UnicodeScalarLiteralType
    
    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self = .init(value: T.init(unicodeScalarLiteral: value))
    }
}
