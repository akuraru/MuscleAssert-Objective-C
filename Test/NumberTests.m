//
//  NumberTests.m
//  MuscleAssert
//
//  Created by akuraru on 2017/01/05.
//
//

#import <XCTest/XCTest.h>
#import "MuscleAssert.h"

@interface NumberTests : XCTestCase
@property (nonatomic) MuscleAssert *assert;
@end

@implementation NumberTests

-(void)setUp {
    [super setUp];
    self.assert = [[MuscleAssert alloc] init];
}

- (void)testEmpty {
    NSNumber *number = @1;
    NSString *diff = [self.assert deepStricEqual:number expected:number message:@""];
    XCTAssertNil(diff);
}

- (void)testIntegerDiff {
    NSNumber *number = @1;
    NSNumber *expectedNumber = @2;
    NSString *diff = [self.assert deepStricEqual:number expected:expectedNumber message:@""];
    XCTAssertEqualObjects(diff, @"\npath: .number\n" "actual: 1\n" "expected: 2\n");
}

- (void)testFloatDiff {
    NSNumber *number = @1.25;
    NSNumber *expectedNumber = @2.5;
    NSString *diff = [self.assert deepStricEqual:number expected:expectedNumber message:@""];
    XCTAssertEqualObjects(diff, @"\npath: .number\n" "actual: 1.25\n" "expected: 2.5\n");
}

- (void)testBoolDiff {
    NSNumber *number = @YES;
    NSNumber *expectedNumber = @NO;
    NSString *diff = [self.assert deepStricEqual:number expected:expectedNumber message:@""];
    XCTAssertEqualObjects(diff, @"\npath: .number\n" "actual: 1\n" "expected: 0\n");
}

@end
