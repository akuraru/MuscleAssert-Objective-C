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
}
/*
@property (nonatomic, nonnull) MuscleAssert *assert;
@end

@implementation MuscleAssertTests

- (void)setUp {
    [super setUp];
    self.assert = [[MuscleAssert alloc] init];
}

- (void)testDeepDiff {
    NSString *diff = [self.assert deepStricEqual:@[@[@"value1"]] right:@[@[@"value2"]]];
    XCTAssertEqualObjects(diff, @"\n"
                          "path: .0.0.5\n"
                          "  left: 1\n"
                          "  right: 2\n"
                          );
}

- (void)testMAssert {
    MAssert(@"a", @"a");
}

- (void)testCustomDiff {
    MUSCustomDiffer *differ = [[MUSCustomDiffer alloc] init];
    XCTAssertEqualObjects([differ diff:@"" right:@"" path:@"" delegatge:self.assert], @[]);
}

- (void)testMatchClass {
    MUSCustomClassDiffer *differ = [[MUSCustomClassDiffer alloc] init];
    XCTAssertNil(differ.matchClass);
}

@end
*/
