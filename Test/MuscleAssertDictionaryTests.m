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

- (void)setUp {
    [super setUp];
    self.assert = [[MuscleAssert alloc] init];
}

- (void)testNone {
    NSString *diff = [self.assert deepStricEqual:@{} right:@{}];
    XCTAssertNil(diff);
}

- (void)testKeyAndValue {
    NSString *diff = [self.assert deepStricEqual:@{@"key": @"value"} right:@{@"key": @"value"}];
    XCTAssertNil(diff);
}

- (void)testEmptyLeft {
    NSString *diff = [self.assert deepStricEqual:@{} right:@{@"key": @"value"}];
    XCTAssertEqualObjects(diff, @"\npath: .key\nleft: value is none\nright: value\n");
}

- (void)testEmptyRight {
    NSString *diff = [self.assert deepStricEqual:@{@"key": @"value"} right:@{}];
    XCTAssertEqualObjects(diff, @"\npath: .key\nleft: value\nright: value is none\n");
}

- (void)testDifferentValue {
    NSString *diff = [self.assert deepStricEqual:@{@"key": @"2016:12:09"} right:@{@"key": @"value"}];
    XCTAssertEqualObjects(diff, @"\npath: .key.0\nleft: 2016:12:09\nright: value\n");
}

- (void)testDifferentKeyAndValue {
    NSString *diff = [self.assert deepStricEqual:@{@"date": @"2016:12:09"} right:@{@"key": @"value"}];
    XCTAssertEqualObjects(diff, @"\n"
        "path: .key\nleft: value is none\nright: value\n"
        "path: .date\nleft: 2016:12:09\nright: value is none\n");
}

@end
