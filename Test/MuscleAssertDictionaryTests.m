//
//  MuscleAssertDictonaryTests.swift
//  MuscleAssert
//
//  Created by akuraru on 2017/01/02.
//
//

#import <XCTest/XCTest.h>
#import "MuscleAssert/MuscleAssert.h"

@interface MuscleAssertDictionaryTests : XCTestCase
@property (nonatomic) MuscleAssert *assert;
@end

@implementation MuscleAssertDictionaryTests

-(void)setUp {
    [super setUp];
    self.assert = [[MuscleAssert alloc] init];
}

- (void)testNone {
    NSString *diff = [self.assert deepStricEqual:@{} expected:@{} message:@""];
    XCTAssertNil(diff);
}

- (void)testKeyAndValue {
    NSString *diff = [self.assert deepStricEqual:@{@"key": @"value"} expected:@{@"key": @"value"} message:@""];
    XCTAssertNil(diff);
}

- (void)testEmptyActual {
    NSString *diff = [self.assert deepStricEqual:@{} expected:@{@"key": @"value"} message:@""];
    XCTAssertEqualObjects(diff, @"\npath: .key\nactual: value is none\nexpected: value\n");
}

- (void)testEmptyExpected {
    NSString *diff = [self.assert deepStricEqual:@{@"key": @"value"} expected:@{} message:@""];
    XCTAssertEqualObjects(diff, @"\npath: .key\nactual: value\nexpected: value is none\n");
}

- (void)testDifferentValue {
    NSString *diff = [self.assert deepStricEqual:@{@"key": @"2016:12:09"} expected:@{@"key": @"value"} message:@""];
    XCTAssertEqualObjects(diff, @"\npath: .key.0\nactual: 2016:12:09\nexpected: value\n");
}

- (void)testDifferentKeyAndValue {
    NSString *diff = [self.assert deepStricEqual:@{@"date": @"2016:12:09"} expected:@{@"key": @"value"} message:@""];
    XCTAssertEqualObjects(diff,  @"\n"
                          "path: .key\nactual: value is none\nexpected: value\n"
                          "path: .date\nactual: 2016:12:09\nexpected: value is none\n");
}

@end
