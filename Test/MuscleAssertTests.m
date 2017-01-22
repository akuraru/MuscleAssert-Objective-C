//
//  File.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import <XCTest/XCTest.h>

#import "MuscleAssert/MuscleAssert.h"

@interface MuscleAssertTests : XCTestCase
@property (nonatomic) MuscleAssert *assert;
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

@end
