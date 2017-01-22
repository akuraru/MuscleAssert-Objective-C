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

- (void)setUp {
    [super setUp];
    self.assert = [[MuscleAssert alloc] init];
    self.assert.deepSearch = YES;
}

- (void)testSameTestModel {
    NSString *diff = [self.assert deepStricEqual:[[TestModel alloc] initWithString:@"abc"] right:[[TestModel alloc] initWithString:@"abc"]];
    XCTAssertNil(diff);
}

- (void)testDifferentType {
    NSString *diff = [self.assert deepStricEqual:@"" right:[[TestModel alloc] initWithString:@"abc"]];
    XCTAssertEqualObjects(diff, @"\npath: .0\nleft: \nright: TestModel(string: abc, number: 0)\n");
}

- (void)testLeftEmpty {
    NSString *diff = [self.assert deepStricEqual:[[TestModel alloc] initWithString:@"" number:@1] right:[[TestModel alloc] initWithString:@"abc"]];
    XCTAssertEqualObjects(diff, @"\n"
        "path: .string.0\nleft: \nright: abc\n"
        "path: .number\nleft: 1\nright: 0\n"
    );
}

@end
