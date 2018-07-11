import Foundation

extension Defaultable: Decodable where T: Decodable {
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            self.value = try container.decode(Default.ValueType.self)
            
        } catch DecodingError.valueNotFound {
            self.value = Default.default
            
        } catch let error {
            throw error
        }
    }
}
extension Defaultable: Encodable where T: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
}

extension KeyedDecodingContainer {
    /// Will attempt to decode the underlying value for a `Defaultable`.
    /// If the key is missing or the value is `null` the default value will be used.
    public func decode<T: Decodable, Default: DefaultValue>(_ type: Defaultable<T, Default>.Type, forKey key: KeyedDecodingContainer.Key) throws -> Defaultable<T, Default> {
        return Defaultable<T, Default>(value: try decodeIfPresent(Default.ValueType.self, forKey: key))
    }
}
extension UnkeyedDecodingContainer {
    /// Will attempt to decode the underlying value for a `Defaultable` at the current index.
    /// If the value is missing or the value is `null` the default value will be used.
    public mutating func decode<T: Decodable, Default: DefaultValue>(_ type: Defaultable<T, Default>.Type) throws -> Defaultable<T, Default> {
        return Defaultable<T, Default>(value: try decodeIfPresent(Default.ValueType.self))
    }
}
