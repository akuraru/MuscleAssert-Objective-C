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
}

- (void)testSameTestModel {
    NSString *diff = [self.assert deepStricEqual:[[TestModel alloc] initWithString:@"abc"] right:[[TestModel alloc] initWithString:@"abc"]];
    XCTAssertNil(diff);
}

- (void)testDifferentType {
    NSString *diff = [self.assert deepStricEqual:@"" right:[[TestModel alloc] initWithString:@"abc"]];
    XCTAssertEqualObjects(diff, @"\npath: .0\n"
                          "  left: \n"
                          "  right: TestModel(string: abc, number: 0)\n");
}

- (void)testLeftEmpty {
    NSString *diff = [self.assert deepStricEqual:[[TestModel alloc] initWithString:@"" number:@1] right:[[TestModel alloc] initWithString:@"abc"]];
    XCTAssertEqualObjects(diff, @"\n"
                          "path: .string.0\n"
                          "  left: \n"
                          "  right: abc\n"
                          "path: .number\n"
                          "  left: 1\n"
                          "  right: 0\n"
                          );
}

@end
