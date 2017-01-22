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

- (void)setUp {
    [super setUp];
    self.assert = [[MuscleAssert alloc] init];
}

- (void)testEmpty {
    NSNumber *number = @1;
    NSString *diff = [self.assert deepStricEqual:number right:number];
    XCTAssertNil(diff);
}

- (void)testIntegerDiff {
    NSNumber *number = @1;
    NSNumber *rightNumber = @2;
    NSString *diff = [self.assert deepStricEqual:number right:rightNumber];
    XCTAssertEqualObjects(diff, @"\npath: .number\n"
                          "  left: 1\n"
                          "  right: 2\n");
}

- (void)testFloatDiff {
    NSNumber *number = @1.25;
    NSNumber *rightNumber = @2.5;
    NSString *diff = [self.assert deepStricEqual:number right:rightNumber];
    XCTAssertEqualObjects(diff, @"\npath: .number\n"
                          "  left: 1.25\n"
                          "  right: 2.5\n");
}

- (void)testBoolDiff {
    NSNumber *number = @YES;
    NSNumber *rightNumber = @NO;
    NSString *diff = [self.assert deepStricEqual:number right:rightNumber];
    XCTAssertEqualObjects(diff, @"\npath: .number\n"
                          "  left: 1\n"
                          "  right: 0\n");
}

@end
