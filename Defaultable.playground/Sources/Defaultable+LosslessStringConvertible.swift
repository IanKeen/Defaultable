import Foundation

extension Defaultable: LosslessStringConvertible where T: LosslessStringConvertible {
    public init?(_ description: String) {
        self.init(value: T.init(description))
    }
}
