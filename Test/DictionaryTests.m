//
//  MuscleAssertDictonaryTests.swift
//  MuscleAssert
//
//  Created by akuraru on 2017/01/02.
//
//

#import <XCTest/XCTest.h>
#import "MuscleAssert/MuscleAssert.h"

@interface DictionaryTests : XCTestCase
@property (nonatomic) MuscleAssert *assert;
@end

@implementation DictionaryTests

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
    XCTAssertEqualObjects(diff, @"\npath: .key\n"
                          "  left: value is none\n"
                          "  right: value\n");
}

- (void)testEmptyRight {
    NSString *diff = [self.assert deepStricEqual:@{@"key": @"value"} right:@{}];
    XCTAssertEqualObjects(diff, @"\npath: .key\n"
                          "  left: value\n"
                          "  right: value is none\n");
}

- (void)testDifferentValue {
    NSString *diff = [self.assert deepStricEqual:@{@"key": @"2016:12:09"} right:@{@"key": @"value"}];
    XCTAssertEqualObjects(diff, @"\npath: .key.0\n"
                          "  left: 2016:12:09\n"
                          "  right: value\n");
}

- (void)testDifferentKeyAndValue {
    NSString *diff = [self.assert deepStricEqual:@{@"date": @"2016:12:09"} right:@{@"key": @"value"}];
    XCTAssertEqualObjects(diff, @"\n"
                          "path: .key\n"
                          "  left: value is none\n"
                          "  right: value\n"
                          "path: .date\n"
                          "  left: 2016:12:09\n"
                          "  right: value is none\n");
}

- (void)testDeepDictionary {
    NSString *diff = [self.assert deepStricEqual:@{@"user": @{ @"name": @"akuraru" } }
                                           right:@{@"user": @{ @"name": @"Akuraru" } }];
    XCTAssertEqualObjects(diff, @"\n"
                          "path: .user.name.0\n"
                          "  left: a\n"
                          "  right: A\n");
}

@end
