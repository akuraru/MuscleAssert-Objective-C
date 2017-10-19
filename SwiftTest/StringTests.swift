//
//  StringTests.swift
//  SwiftTest
//
//  Created by akuraru on 2017/10/20.
//

import XCTest
@testable import MuscleAssert

class StringTests: XCTestCase {
    let assert = MuscleAssert()
    
    func testEmpty() {
        let diff = self.assert.deepStricEqual(left: "", right: "")
        XCTAssertNil(diff)
    }
    
    func testLongEqual() {
        let diff = self.assert.deepStricEqual(left: "abc", right: "abc")
        XCTAssertNil(diff)
    }
    
    func testEmptyRight() {
        let diff = self.assert.deepStricEqual(left: "a", right: "")
        XCTAssertEqual(diff!, "\npath: .0\n" +
            "  left: a\n" +
            "  right: \n");
    }
    
    func testEmptyLeft() {
        let diff = self.assert.deepStricEqual(left: "", right: "a")
        XCTAssertEqual(diff!, "\npath: .0\n" +
            "  left: \n" +
            "  right: a\n");
    }
    
    func testFirst() {
        let diff = self.assert.deepStricEqual(left: "a", right: "b")
        XCTAssertEqual(diff!, "\npath: .0\n" +
            "  left: a\n" +
            "  right: b\n");
    }
    
    func testTooLongLeft() {
        let diff = self.assert.deepStricEqual(left: "abc123", right: "abc")
        XCTAssertEqual(diff!, "\npath: .3\n" +
            "  left: 123\n" +
            "  right: \n");
    }
    
    func testTooLongRight() {
        let diff = self.assert.deepStricEqual(left: "abc", right: "abc123")
        XCTAssertEqual(diff!, "\npath: .3\n" +
            "  left: \n" +
            "  right: 123\n");
    }
    
    func testJapanises() {
        let diff = self.assert.deepStricEqual(left: "あいうえお", right: "あいうねお")
        XCTAssertEqual(diff!, "\npath: .3\n" +
            "  left: え\n" +
            "  right: ね\n");
    }
    
    func testEmoji() {
        let diff = self.assert.deepStricEqual(left: "👨‍👩‍👧‍👦", right: "👨")
        XCTAssertEqual(diff!, "\npath: .0\n" +
            "  left: 👨‍👩‍👧‍👦\n" +
            "  right: 👨\n");
    }
    
    func testLongDiff() {
        let diff = self.assert.deepStricEqual(left: "aXbcdYe", right:"abcZdVe")
        XCTAssertEqual(diff!, "\n" +
            "path: .1\n" +
            "  left: X\n" +
            "  right: \n" +
            "path: .3\n" +
            "  left: \n" +
            "  right: Z\n" +
            "path: .4\n" +
            "  left: Y\n" +
            "  right: V\n"
        );
    }
}
