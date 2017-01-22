//
//  MuscleAssertStringTests.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/25.
//
//

#import <XCTest/XCTest.h>
#import "MuscleAssert.h"

@interface MuscleAssertStringTests : XCTestCase
@property (nonatomic) MuscleAssert *assert;
@end

@implementation MuscleAssertStringTests

- (void)setUp {
    [super setUp];
    self.assert = [[MuscleAssert alloc] init];
}

- (void)testEmpty {
    NSString *diff = [self.assert deepStricEqual:@"" right:@"" message:@""];
    XCTAssertNil(diff);
}

- (void)testLongEqual {
    NSString *diff = [self.assert deepStricEqual:@"abc" right:@"abc" message:@""];
    XCTAssertNil(diff);
}

- (void)testEmptyRight {
    NSString *diff = [self.assert deepStricEqual:@"a" right:@"" message:@""];
    XCTAssertEqualObjects(diff, @"\npath: .0\n" "left: a\n" "right: \n");
}

- (void)testEmptyLeft {
    NSString *diff = [self.assert deepStricEqual:@"" right:@"b" message:@""];
    XCTAssertEqualObjects(diff,
        @"\npath: .0\n"
            "left: \n"
            "right: b\n"
    );
}

- (void)testFirst {
    NSString *diff = [self.assert deepStricEqual:@"a" right:@"b" message:@""];
    XCTAssertEqualObjects(diff,
        @"\npath: .0\n"
            "left: a\n"
            "right: b\n"
    );
}

- (void)testLongLeft {
    NSString *diff = [self.assert deepStricEqual:@"abc123" right:@"abc" message:@""];
    XCTAssertEqualObjects(diff,
        @"\npath: .3\n"
            "left: 123\n"
            "right: \n"
    );
}

- (void)testLongRight {
    NSString *diff = [self.assert deepStricEqual:@"abc" right:@"abc123" message:@""];
    XCTAssertEqualObjects(diff,
        @"\npath: .3\n"
            "left: \n"
            "right: 123\n"
    );
}

- (void)testJapanese {
    NSString *diff = [self.assert deepStricEqual:@"あいうえお" right:@"あいうねお" message:@""];
    XCTAssertEqualObjects(diff,
        @"\npath: .3\n"
            "left: え\n"
            "right: ね\n"
    );
}

- (void)testLongDiff {
    NSString *diff = [self.assert deepStricEqual:@"aXbcdYe" right:@"abcZdVe" message:@""];
    XCTAssertEqualObjects(diff, @"\n"
        "path: .1\n" "left: X\n" "right: \n"
        "path: .3\n" "left: \n" "right: Z\n"
        "path: .4\n" "left: Y\n" "right: V\n"
    );
}

@end
