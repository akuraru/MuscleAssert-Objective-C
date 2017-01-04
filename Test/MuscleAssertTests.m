//
//  File.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import <XCTest/XCTest.h>

#import <XCTest/XCTest.h>
#import "MuscleAssert/MuscleAssert.h"

@interface MuscleAssertTests : XCTestCase
@property (nonatomic) MuscleAssert *assert;
@end

@implementation MuscleAssertTests

-(void)setUp {
    [super setUp];
    self.assert = [[MuscleAssert alloc] init];
}

- (void)testDeepDiff {
    NSString *diff = [self.assert deepStricEqual:@[@[@"value1"]] expected:@[@[@"value2"]] message:@""];
    XCTAssertEqualObjects(diff, @"\n"
                          "path: .0.0.5\nactual: 1\nexpected: 2\n"
                          );
}

@end
