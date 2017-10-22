//
//  CustomDebugStringConvertibleTests.swift
//  SwiftTest
//
//  Created by akuraru on 2017/10/21.
//

import XCTest
@testable import MuscleAssert

class CustomDebugStringConvertibleTests: XCTestCase {
    let assert = MuscleAssert()
    
    func testSameTestModel() {
        let diff = assert.deepStricEqual(left: TestModel(string: "abc"), right: TestModel(string: "abc"))
        XCTAssertNil(diff);
    }
    
    func testDifferentType() {
        let diff = assert.deepStricEqual(left: "", right: TestModel(string: "abc"))
        XCTAssertEqual(diff!, "\npath: .0\n" +
            "  left: \n" +
            "  right: TestModel(string: abc, integer: 0)\n")
    }
    
    func testLeftEmpty() {
        let diff = assert.deepStricEqual(left: TestModel(string: ""), right: TestModel(string: "abc", integer: 1))
        XCTAssertEqual(diff!, "\npath: .string\n" +
            "  left: \n" +
            "  right: abc\n" +
            "\npath: .integer\n" +
            "  left: 0\n" +
            "  right: 1\n")
    }
}
