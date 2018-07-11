import Foundation

private struct Model: Codable, Equatable {
    let single: Defaultable<Bool, True>
    let array: [Defaultable<Bool, True>]
    let nested: DefaultableArray<Defaultable<Bool, True>>
}
private struct Pair {
    let input: String
    let expected: TestResult<Model>
}
private extension TestCase {
    static func create(from pair: Pair) -> TestCase<Model> {
        return .init(
            after: { try JSONDecoder().decode(Model.self, from: pair.input.data(using: .utf8)!) },
            expect: pair.expected
        )
    }
}

private class Tests: XCTestCase {
    func test() throws {
        let pairs = [
            //Single tests
            Pair(input: "{\"single\": true, \"array\": []}", expected: .success(Model(single: true, array: [], nested: []))),
            Pair(input: "{\"single\": false, \"array\": []}", expected: .success(Model(single: false, array: [], nested: []))),
            Pair(input: "{\"single\": null, \"array\": []}", expected: .success(Model(single: true, array: [], nested: []))),
            Pair(input: "{\"array\": []}", expected: .success(Model(single: true, array: [], nested: []))),
            
            //Required array tests
            Pair(input: "{\"array\": [true, false, null]}", expected: .success(Model(single: true, array: [true, false, true], nested: []))),
            
            //Nested array tests
            Pair(input: "{\"array\": [], \"nested\": []}", expected: .success(Model(single: true, array: [], nested: []))),
            Pair(input: "{\"array\": [], \"nested\": null}", expected: .success(Model(single: true, array: [], nested: []))),
            Pair(input: "{\"array\": [], \"nested\": [true, false, null]}", expected: .success(Model(single: true, array: [], nested: [true, false, true]))),
            ]
        
        let tests = pairs.map(TestCase<Model>.create)
        
        for test in tests {
            test.execute()
        }
    }
}
Tests.run()
