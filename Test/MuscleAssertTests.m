//
//  File.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import <XCTest/XCTest.h>
#import "MuscleAssert/MuscleAssert.h"
#import "MuscleAssert/MAStringDiffer.h"

@interface MuscleAssertTests : XCTestCase
@property (nonatomic, nonnull) MuscleAssert *assert;
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

- (void)testMAssert {
    MAssert(@"a", @"a");
}

- (void)testCustomDiff {
    MACustomDiff *differ = [[MACustomDiff alloc] init];
    XCTAssertEqualObjects([differ diff:@"" right:@"" path:@"" delegatge:self.assert], @[]);
}

- (void)testMatchClass {
    MACustomClassDiff *differ = [[MACustomClassDiff alloc] init];
    XCTAssertNil(differ.matchClass);
}

@end
