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

-(void)setUp {
    [super setUp];
    self.assert = [[MuscleAssert alloc] init];
}

- (void)testEmpty {
    NSString *diff = [self.assert deepStricEqual:@"" expected:@"" message:@""];
    XCTAssertNil(diff);
}

- (void)testLongEqual {
    NSString *diff = [self.assert deepStricEqual:@"abc" expected:@"abc" message:@""];
    XCTAssertNil(diff);
}

- (void)testEmptyExpected {
    NSString *diff = [self.assert deepStricEqual:@"a" expected:@"" message:@""];
    XCTAssertEqualObjects(diff, @"\npath: .0\n" "actual: a\n" "expected: \n");
}

- (void)testEmptyActual {
    NSString *diff = [self.assert deepStricEqual:@"" expected:@"b" message:@""];
    XCTAssertEqualObjects(diff,
                          @"\npath: .0\n"
                          "actual: \n"
                          "expected: b\n"
                          );
}

- (void)testFirst {
    NSString *diff = [self.assert deepStricEqual:@"a" expected:@"b" message:@""];
    XCTAssertEqualObjects(diff,
                          @"\npath: .0\n"
                          "actual: a\n"
                          "expected: b\n"
                          );
}

- (void)testLongActual {
    NSString *diff = [self.assert deepStricEqual:@"abc123" expected:@"abc" message:@""];
    XCTAssertEqualObjects(diff,
                          @"\npath: .3\n"
                          "actual: 123\n"
                          "expected: \n"
                          );
}

- (void)testLongExpected {
    NSString *diff = [self.assert deepStricEqual:@"abc" expected:@"abc123" message:@""];
    XCTAssertEqualObjects(diff,
                          @"\npath: .3\n"
                          "actual: \n"
                          "expected: 123\n"
                          );
}

- (void)testLongDiff {
    NSString *diff = [self.assert deepStricEqual:@"aXbcdYe" expected:@"abcZdVe" message:@""];
    XCTAssertEqualObjects(diff,@"\n"
                          "path: .1\n" "actual: X\n" "expected: \n"
                          "path: .3\n" "actual: \n" "expected: Z\n"
                          "path: .4\n" "actual: Y\n" "expected: V\n"
                          );
}

@end
