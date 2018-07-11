import Foundation

extension Defaultable: ExpressibleByIntegerLiteral where T: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = T.IntegerLiteralType
    
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(value: T.init(integerLiteral: value))
    }
}
