import Foundation

extension Defaultable: ExpressibleByNilLiteral {
    public init(nilLiteral: ()) {
        self = .init(value: nil)
    }
}
