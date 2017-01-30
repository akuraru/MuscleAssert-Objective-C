//
//  MuscleAssertDifferenceTests.m
//  MuscleAssert
//
//  Created by akuraru on 2017/01/29.
//
//

#import <XCTest/XCTest.h>
#import "MUSDifference.h"

@interface DifferenceTests : XCTestCase
@end

@implementation DifferenceTests

- (void)testDebugDescription {
    MUSDifference *defference = [[MUSDifference alloc] initWithPath:@"path" left:@"left" right:@"right"];
    XCTAssertEqualObjects([defference debugDescription], @"MuscleAssertDifference(path: path, left: left, right: right)");
}

@end
