//
//  File.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

import XCTest
@testable import MuscleAssert

class MuscleAssertTests : XCTestCase {
    let assert = MuscleAssert()
    
    func testDeepDiff() {
        let deff = assert.deepStricEqual(left: [["value1"]], right: [["value2"]])
        XCTAssertEqual(deff!, "\n" +
            "path: .0.0.5\n" +
            "  left: 1\n" +
            "  right: 2\n"
        )
    }
    
    func testMAssert() {
        XCTAssertNil(assert.deepStricEqual(left: "a", right:  "a"))
    }
}
