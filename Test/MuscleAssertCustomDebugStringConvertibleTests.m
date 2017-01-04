//
//  MuscleAssertCustomDebugStringConvertibleTests.swift
//  MuscleAssert
//
//  Created by akuraru on 2017/01/02.
//
//

import Foundation
import MuscleAssert
import XCTest

struct TestModel {
    let string: String
}

extension TestModel: Equatable {
    public static func ==(lhs: TestModel, rhs: TestModel) -> Bool{
        return lhs.string == rhs.string
    }
}
extension TestModel: CustomDebugStringConvertible {
    var debugDescription: String {
        return "TestModel(string: \(string))"
    }
}

class MuscleAssertCustomDebugStringConvertibleTests : XCTestCase {
    func testEmpty() {
        let diff = MuscleAssert.diff(expected: TestModel(string: ""), actual: TestModel(string: ""))
        let format = MuscleAssert.format(message: nil, differences: diff)
        XCTAssertEqual(format, "")
    }
    func testActualNone() {
        let diff = MuscleAssert.diff(expected: TestModel(string: "abc"), actual: TestModel(string: ""))
        let format = MuscleAssert.format(message: nil, differences: diff)
        XCTAssertEqual(format, "\npath: .0\nactual: TestModel(string: )\nexpected: TestModel(string: abc)\n")
    }
}


