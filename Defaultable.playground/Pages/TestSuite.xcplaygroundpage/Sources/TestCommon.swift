import Foundation
@_exported import XCTest

public enum TestResult<T: Equatable> {
    case success(T)
    case failure(Error)
}

public struct TestCase<T: Equatable> {
    private let after: () throws -> T
    private let expect: TestResult<T>
    
    public init(after: @escaping () throws -> T, expect: TestResult<T>) {
        self.after = after
        self.expect = expect
    }
    
    public func execute(file: StaticString = #file, line: UInt = #line) {
        do {
            let value = try after()
            
            switch expect {
            case .success(let expected):
                XCTAssertEqual(value, expected, file: file, line: line)
            case .failure:
                XCTFail("Received unexpected success: \(value)", file: file, line: line)
            }
        } catch let error {
            switch expect {
            case .failure(let expected):
                XCTAssertEqual("\(error)", "\(expected)", file: file, line: line)
            case .success:
                XCTFail("Received unexpected failure: \(error)", file: file, line: line)
            }
        }
    }
}

public extension XCTestCase {
    public static func run() {
        XCTestSuite(forTestCaseClass: self).run()
    }
}
