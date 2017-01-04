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

-(void)setUp {
    [super setUp];
    self.assert = [[MuscleAssert alloc] init];
}

- (void)testNone {
    NSString *diff = [self.assert deepStricEqual:@[] expected:@[] message:@""];
    XCTAssertNil(diff);
}

- (void)testKeyAndValue {
    NSString *diff = [self.assert deepStricEqual:@[@"value"] expected:@[@"value"] message:@""];
    XCTAssertNil(diff);
}

- (void)testEmptyActual {
    NSString *diff = [self.assert deepStricEqual:@[] expected:@[@"value"] message:@""];
    XCTAssertEqualObjects(diff, @"\npath: .0..<1\nactual: too sort\nexpected: (\n    value\n)\n");
}

- (void)testEmptyExpected {
    NSString *diff = [self.assert deepStricEqual:@[@"value"] expected:@[] message:@""];
    XCTAssertEqualObjects(diff, @"\npath: .0..<1\nactual: (\n    value\n)\nexpected: too sort\n");
}

- (void)testDifferentValue {
    NSString *diff = [self.assert deepStricEqual:@[[[TestModel alloc] initWithString:@"value"]] expected:@[[[TestModel alloc] initWithString:@"2016:12:09"]] message:@""];
    XCTAssertEqualObjects(diff, @"\npath: .0\nactual: TestModel(string: value)\nexpected: TestModel(string: 2016:12:09)\n");
}

@end
