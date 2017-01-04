//
//  MuscleAssertArrayTests.swift
//  MuscleAssert
//
//  Created by akuraru on 2017/01/03.
//
//

import Foundation
import MuscleAssert
import XCTest

extension Array where Element : Equatable {
    public static func ==(lhs: Array<Element>, rhs: Array<Element>) -> Bool {
        for (l, r) in zip(lhs, rhs) {
            if l != r {
                return false
            }
        }
        return true
    }
}

extension Array: Equatable where {
}

class MuscleAssertArrayTests : XCTestCase {
    func testNone() {
        let format = MuscleAssert.deepStricEqual(actual: [] as [String], expected: [] as [String])
        XCTAssertEqual(format, "")
    }
    func testKeyAndValue() {
        let format = MuscleAssert.deepStricEqual(actual: ["value"], expected: ["value"])
        XCTAssertEqual(format, "")
    }
    func testEmptyActual() {
        let diff = MuscleAssert.diff(expected: ["value"], actual: [])
        let format = MuscleAssert.format(message: nil, differences: diff)
        XCTAssertEqual(format, "\npath: .0..<1\nactual: too sort\nexpected: [\"value\"]\n")
    }
    func testEmptyExpected() {
        let diff = MuscleAssert.diff(expected: [], actual: ["value"])
        let format = MuscleAssert.format(message: nil, differences: diff)
        XCTAssertEqual(format, "\npath: .0..<1\nactual: [\"value\"]\nexpected: too sort\n")
    }
    func testDifferentValue() {
        let diff = MuscleAssert.diff(expected: ["2016:12:09"], actual: ["value"])
        let format = MuscleAssert.format(message: nil, differences: diff)
        XCTAssertEqual(format, "\npath: .0\nactual: \"value\"\nexpected: \"2016:12:09\"\n")
    }
}
