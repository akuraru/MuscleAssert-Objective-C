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
    NSString *diff = [self.assert deepStricEqual:@"" right:@""];
    XCTAssertNil(diff);
}

- (void)testLongEqual {
    NSString *diff = [self.assert deepStricEqual:@"abc" right:@"abc"];
    XCTAssertNil(diff);
}

- (void)testEmptyRight {
    NSString *diff = [self.assert deepStricEqual:@"a" right:@""];
    XCTAssertEqualObjects(diff, @"\npath: .0\n"
                          "  left: a\n"
                          "  right: \n");
}

- (void)testEmptyLeft {
    NSString *diff = [self.assert deepStricEqual:@"" right:@"b"];
    XCTAssertEqualObjects(diff,
                          @"\npath: .0\n"
                          "  left: \n"
                          "  right: b\n"
                          );
}

- (void)testFirst {
    NSString *diff = [self.assert deepStricEqual:@"a" right:@"b"];
    XCTAssertEqualObjects(diff,
                          @"\npath: .0\n"
                          "  left: a\n"
                          "  right: b\n"
                          );
}

- (void)testLongLeft {
    NSString *diff = [self.assert deepStricEqual:@"abc123" right:@"abc"];
    XCTAssertEqualObjects(diff,
                          @"\npath: .3\n"
                          "  left: 123\n"
                          "  right: \n"
                          );
}

- (void)testLongRight {
    NSString *diff = [self.assert deepStricEqual:@"abc" right:@"abc123"];
    XCTAssertEqualObjects(diff,
                          @"\npath: .3\n"
                          "  left: \n"
                          "  right: 123\n"
                          );
}

- (void)testJapanese {
    NSString *diff = [self.assert deepStricEqual:@"あいうえお" right:@"あいうねお"];
    XCTAssertEqualObjects(diff,
                          @"\npath: .3\n"
                          "  left: え\n"
                          "  right: ね\n"
                          );
}

- (void)testLongDiff {
    NSString *diff = [self.assert deepStricEqual:@"aXbcdYe" right:@"abcZdVe"];
    XCTAssertEqualObjects(diff, @"\n"
                          "path: .1\n"
                          "  left: X\n"
                          "  right: \n"
                          "path: .3\n"
                          "  left: \n"
                          "  right: Z\n"
                          "path: .4\n"
                          "  left: Y\n"
                          "  right: V\n"
                          );
}

@end
