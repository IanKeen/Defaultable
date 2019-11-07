import Foundation

// example default value provider
struct FortyTwo<N: Numeric>: DefaultValue {
    static var `default`: N { return 42 }
}

// example model
struct Model: Codable, Hashable {
    @Defaultable<Bool, True> var bool: Bool
    @Defaultable<Float, Zero<Float>> var float: Float
    @Defaultable<Int, FortyTwo<Int>> var int: Int
    @Defaultable<String, EmptyString> var string: String
}

// codable
// decoded using all defaults
let decodedA = try! JSONDecoder().decode(Model.self, from: "{}".data(using: .utf8)!)
print("DECODED A", decodedA)

// decoded using all values that _aren't_ defaults
let json = """
{"bool": false, "float": 3, "int": 7, "string": "hi"}
""".data(using: .utf8)!
let decodedB = try! JSONDecoder().decode(Model.self, from: json)
print("DECODED B", decodedB)

// encoded
let model = Model(bool: true, float: 111, int: 222, string: "333")
let encoded = String(data: try JSONEncoder().encode(model), encoding: .utf8)!
print("ENCODED", encoded)
