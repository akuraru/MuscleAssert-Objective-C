//
//  MuscleAssertOptionalTests.swift
//  MuscleAssert
//
//  Created by akuraru on 2017/01/02.
//
//

#import <XCTest/XCTest.h>
#import "MuscleAssert/MuscleAssert.h"

@interface MuscleAssertOptionalTests : XCTestCase
@property (nonatomic) MuscleAssert *assert;
@end

@implementation MuscleAssertOptionalTests

-(void)setUp {
    [super setUp];
    self.assert = [[MuscleAssert alloc] init];
}

- (void)testNone {
    NSString *diff = [self.assert deepStricEqual:nil expected:nil message:@""];
    XCTAssertNil(diff);
}

- (void)testActualNone {
    NSString *diff = [self.assert deepStricEqual:nil expected:@"abc" message:@""];
    XCTAssertEqualObjects(diff, @"\npath: .Optional\nactual: value is none\nexpected: abc\n");
}

- (void)testEmptyExpected {
    NSString *diff = [self.assert deepStricEqual:@"abc" expected:nil message:@""];
    XCTAssertEqualObjects(diff, @"\npath: .Optional\nactual: abc\nexpected: value is none\n");
}

@end
