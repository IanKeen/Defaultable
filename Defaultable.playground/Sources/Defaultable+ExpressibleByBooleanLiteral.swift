import Foundation

extension Defaultable: ExpressibleByBooleanLiteral where T: ExpressibleByBooleanLiteral {
    public typealias BooleanLiteralType = T.BooleanLiteralType
    
    public init(booleanLiteral value: BooleanLiteralType) {
        self = .init(value: T.init(booleanLiteral: value))
    }
}
