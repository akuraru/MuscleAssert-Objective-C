//
//  MuscleAssertOptionalTests.swift
//  MuscleAssert
//
//  Created by akuraru on 2017/01/02.
//
//

import Foundation
import MuscleAssert
import XCTest

class MuscleAssertOptionalTests : XCTestCase {
    func testNone() {
        let diff = MuscleAssert.diff(expected: Optional<String>.none, actual: Optional<String>.none)
        let format = MuscleAssert.format(message: nil, differences: diff)
        XCTAssertEqual(format, "")
    }
    func testActualNone() {
        let diff = MuscleAssert.diff(expected: "abc", actual: Optional<String>.none)
        let format = MuscleAssert.format(message: nil, differences: diff)
        XCTAssertEqual(format, "\npath: .Optional\nactual: value is nooe\nexpected: \"abc\"\n")
    }
    func testEmptyExpected() {
        let diff = MuscleAssert.diff(expected: .none, actual: "abc")
        let format = MuscleAssert.format(message: nil, differences: diff)
        XCTAssertEqual(format, "\npath: .Optional\nactual: \"abc\"\nexpected: value is none\n")
    }
    func testSameSomeString() {
        let diff = MuscleAssert.diff(expected: Optional<String>.some("abc"), actual: "abc")
        let format = MuscleAssert.format(message: nil, differences: diff)
        XCTAssertEqual(format, "")
    }
}
