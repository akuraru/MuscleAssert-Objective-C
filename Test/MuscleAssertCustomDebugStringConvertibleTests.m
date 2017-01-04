//
//  MuscleAssertCustomDebugStringConvertibleTests.swift
//  MuscleAssert
//
//  Created by akuraru on 2017/01/02.
//
//

#import <XCTest/XCTest.h>
#import "MuscleAssert/MuscleAssert.h"
#import "TestModel.h"

@interface MuscleAssertCustomDebugStringConvertibleTests : XCTestCase
@property (nonatomic) MuscleAssert *assert;
@end

@implementation MuscleAssertCustomDebugStringConvertibleTests

-(void)setUp {
    [super setUp];
    self.assert = [[MuscleAssert alloc] init];
}

- (void)testSameTestModel {
    NSString *diff = [self.assert deepStricEqual:[[TestModel alloc] initWithString:@"abc"] expected:[[TestModel alloc] initWithString:@"abc"] message:@""];
    XCTAssertNil(diff);
}

- (void)testDifferentType {
    NSString *diff = [self.assert deepStricEqual:@"" expected:[[TestModel alloc] initWithString:@"abc"] message:@""];
    XCTAssertEqualObjects(diff, @"\npath: .0\nactual: \nexpected: TestModel(string: abc)\n");
}

- (void)testActualEmpty {
    NSString *diff = [self.assert deepStricEqual:[[TestModel alloc] initWithString:@""] expected:[[TestModel alloc] initWithString:@"abc"] message:@""];
    XCTAssertEqualObjects(diff, @"\npath: .0\nactual: TestModel(string: )\nexpected: TestModel(string: abc)\n");
}

@end
