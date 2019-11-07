import Foundation
import XCTest

private struct Model: Codable, Equatable {
    @Defaultable<Bool, True>
    var single: Bool

    @DefaultableArray<Bool>
    var array: [Bool]
}

private struct Pair {
    let file: StaticString
    let line: UInt
    let input: String
    let expected: Model

    init(file: StaticString = #file, line: UInt = #line, input: String, expected: Model) {
        self.file = file
        self.line = line
        self.input = input
        self.expected = expected
    }
}

private class Tests: XCTestCase {
    func test() throws {
        let pairs = [
            //Total nil tests
            Pair(input: "{}", expected: Model(single: true, array: [])),

            //Single tests
            Pair(input: "{\"single\": true, \"array\": []}", expected: Model(single: true, array: [])),
            Pair(input: "{\"single\": false, \"array\": []}", expected: Model(single: false, array: [])),
            Pair(input: "{\"single\": null, \"array\": []}", expected: Model(single: true, array: [])),
            Pair(input: "{\"array\": []}", expected: Model(single: true, array: [])),

            //Required array tests
            Pair(input: "{\"array\": [true, false]}", expected: Model(single: true, array: [true, false])),
        ]

        for pair in pairs {
            do {
                let value = try JSONDecoder().decode(Model.self, from: pair.input.data(using: .utf8)!)
                XCTAssertEqual(value, pair.expected, file: pair.file, line: pair.line)

            } catch let error {
                XCTAssertEqual("\(error)", "\(pair.expected)", file: pair.file, line: pair.line)
            }
        }
    }
}
XCTestSuite(forTestCaseClass: Tests.self).run()
