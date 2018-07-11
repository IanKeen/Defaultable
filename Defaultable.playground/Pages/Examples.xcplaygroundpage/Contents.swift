import Foundation
// example default value provider
struct FortyTwo<N: Numeric>: DefaultValue {
    static var `default`: N { return 42 }
}

// example model
struct Model: Codable, Hashable {
    let bool: Defaultable<Bool, True>
    let float: Defaultable<Float, Zero<Float>>
    let int: Defaultable<Int, FortyTwo<Int>>
    let string: Defaultable<String, EmptyString>
}

// literals
// all defaults
let a = Model(bool: nil, float: nil, int: nil, string: nil)
print("A", a)

// all values that _aren't_ the default
let b = Model(bool: false, float: 3, int: 7, string: "hi")
print("B", b)

// equatable
a.bool == b.bool
Defaultable<Bool, True>(value: nil) == true
false == Defaultable<Bool, True>(value: false)

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

// encoded using all defaults
let encodedA = String(data: try JSONEncoder().encode(a), encoding: .utf8)!
print("ENCODED A", encodedA)

// encoded using all values that _aren't_ defaults
let encodedB = String(data: try JSONEncoder().encode(b), encoding: .utf8)!
print("ENCODED B", encodedB)
