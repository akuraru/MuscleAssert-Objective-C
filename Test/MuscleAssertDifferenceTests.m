//
//  MuscleAssertDifferenceTests.m
//  MuscleAssert
//
//  Created by akuraru on 2017/01/29.
//
//

#import <XCTest/XCTest.h>
#import "MuscleAssertDifference.h"

@interface MuscleAssertDifferenceTests : XCTestCase
@end

@implementation MuscleAssertDifferenceTests

- (void)testDebugDescription {
    MuscleAssertDifference *defference = [[MuscleAssertDifference alloc] initWithPath:@"path" left:@"left" right:@"right"];
    XCTAssertEqualObjects([defference debugDescription], @"MuscleAssertDifference(path: path, left: left, right: right)");
}

@end
