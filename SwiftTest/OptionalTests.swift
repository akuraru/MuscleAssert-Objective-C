//
//  OptionalTests.swift
//  SwiftTest
//
//  Created by akuraru on 2017/10/21.
//

import XCTest
@testable import MuscleAssert

class OptionalTests: XCTestCase {
    let assert = MuscleAssert()
    
    func testNone() {
        let diff = assert.deepStricEqual(left: nil, right: nil)
        XCTAssertNil(diff);
    }
    
    func testLeftNone() {
        let diff = assert.deepStricEqual(left: nil, right: "abc")
        XCTAssertEqual(diff, "\npath: .Optional\n" +
            "  left: value is none\n" +
            "  right: abc\n")
    }
    
    func testEmptyRight() {
        let diff = assert.deepStricEqual(left: "abc", right: nil)
        XCTAssertEqual(diff, "\npath: .Optional\n" +
            "  left: abc\n" +
            "  right: value is none\n")
    }
}
