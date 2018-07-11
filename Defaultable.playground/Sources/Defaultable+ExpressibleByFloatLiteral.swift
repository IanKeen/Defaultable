import Foundation

extension Defaultable: ExpressibleByFloatLiteral where T: ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = T.FloatLiteralType
    
    public init(floatLiteral value: FloatLiteralType) {
        self.init(value: T.init(floatLiteral: value))
    }
}
