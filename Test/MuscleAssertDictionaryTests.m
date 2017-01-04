//
//  MuscleAssertDictonaryTests.swift
//  MuscleAssert
//
//  Created by akuraru on 2017/01/02.
//
//

import Foundation
import MuscleAssert
import XCTest

class MuscleAssertDictionaryTests : XCTestCase {
    func testNone() {
        let diff = MuscleAssert.diff(expected: [:] as [String: String], actual: [:])
        let format = MuscleAssert.format(message: nil, differences: diff)
        XCTAssertEqual(format, "")
    }
    func testKeyAndValue() {
        let diff = MuscleAssert.diff(expected: ["key": "value"], actual: ["key": "value"])
        let format = MuscleAssert.format(message: nil, differences: diff)
        XCTAssertEqual(format, "")
    }
    func testEmptyActual() {
        let diff = MuscleAssert.diff(expected: ["key": "value"], actual: [:])
        let format = MuscleAssert.format(message: nil, differences: diff)
        XCTAssertEqual(format, "\npath: .key\nactual: value is none\nexpected: \"value\"\n")
    }
    func testEmptyExpected() {
        let diff = MuscleAssert.diff(expected: [:], actual: ["key": "value"])
        let format = MuscleAssert.format(message: nil, differences: diff)
        XCTAssertEqual(format, "\npath: .key\nactual: \"value\"\nexpected: value is none\n")
    }
    func testDifferentValue() {
        let diff = MuscleAssert.diff(expected: ["key": "2016:12:09"], actual: ["key": "value"])
        let format = MuscleAssert.format(message: nil, differences: diff)
        XCTAssertEqual(format, "\npath: .key\nactual: \"value\"\nexpected: \"2016:12:09\"\n")
    }
    func testDifferentKeyAndValue() {
        let diff = MuscleAssert.diff(expected: ["date": "2016:12:09"], actual: ["key": "value"])
        let format = MuscleAssert.format(message: nil, differences: diff)
        XCTAssertEqual(format, "\npath: .date\nactual: value is none\nexpected: \"2016:12:09\"\n" +
            "path: .key\nactual: \"value\"\nexpected: value is none\n")
    }
}

