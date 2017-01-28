//
//  MuscleAssertArrayTests.swift
//  MuscleAssert
//
//  Created by akuraru on 2017/01/03.
//
//


#import <XCTest/XCTest.h>
#import "MuscleAssert/MuscleAssert.h"
#import "TestModel.h"

@interface MuscleAssertArrayTests : XCTestCase
@property (nonatomic) MuscleAssert *assert;
@end

@implementation MuscleAssertArrayTests

- (void)setUp {
    [super setUp];
    self.assert = [[MuscleAssert alloc] init];
}

- (void)testNone {
    NSString *diff = [self.assert deepStricEqual:@[] right:@[]];
    XCTAssertNil(diff);
}

- (void)testKeyAndValue {
    NSString *diff = [self.assert deepStricEqual:@[@"value"] right:@[@"value"]];
    XCTAssertNil(diff);
}

- (void)testEmptyLeft {
    NSString *diff = [self.assert deepStricEqual:@[] right:@[@"value"]];
    XCTAssertEqualObjects(diff, @"\npath: .0..<1\n"
                          "  left: too sort\n"
                          "  right: (\n    value\n)\n");
}

- (void)testEmptyRight {
    NSString *diff = [self.assert deepStricEqual:@[@"value"] right:@[]];
    XCTAssertEqualObjects(diff, @"\npath: .0..<1\n"
                          "  left: (\n    value\n)\n"
                          "  right: too sort\n");
}

- (void)testDifferentValue {
    NSString *diff = [self.assert deepStricEqual:@[[[TestModel alloc] initWithString:@"value"]] right:@[[[TestModel alloc] initWithString:@"2016:12:09"]]];
    XCTAssertEqualObjects(diff, @"\npath: .string.0\n"
                          "  left: value\n"
                          "  right: 2016:12:09\n");
}

@end
