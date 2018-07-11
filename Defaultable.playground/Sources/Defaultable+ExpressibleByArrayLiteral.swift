import Foundation

public protocol ArrayConvertible {
    associatedtype Element
    
    init(items: [Element])
}
extension Array: ArrayConvertible {
    public init(items: [Element]) {
        self = items
    }
}
extension Set: ArrayConvertible {
    public init(items: [Element]) {
        self = Set(items)
    }
}

extension Defaultable: ExpressibleByArrayLiteral where T: ArrayConvertible {
    public typealias ArrayLiteralElement = T.Element
    
    public init(arrayLiteral elements: ArrayLiteralElement...) {
        self = .init(value: T.init(items: elements))
    }
}
