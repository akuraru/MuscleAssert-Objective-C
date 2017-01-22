//
//  MuscleAssertOptionalTests.swift
//  MuscleAssert
//
//  Created by akuraru on 2017/01/02.
//
//

#import <XCTest/XCTest.h>
#import "MuscleAssert/MuscleAssert.h"

@interface MuscleAssertOptionalTests : XCTestCase
@property (nonatomic) MuscleAssert *assert;
@end

@implementation MuscleAssertOptionalTests

- (void)setUp {
    [super setUp];
    self.assert = [[MuscleAssert alloc] init];
}

- (void)testNone {
    NSString *diff = [self.assert deepStricEqual:nil right:nil message:@""];
    XCTAssertNil(diff);
}

- (void)testLeftNone {
    NSString *diff = [self.assert deepStricEqual:nil right:@"abc" message:@""];
    XCTAssertEqualObjects(diff, @"\npath: .Optional\nleft: value is none\nright: abc\n");
}

- (void)testEmptyRight {
    NSString *diff = [self.assert deepStricEqual:@"abc" right:nil message:@""];
    XCTAssertEqualObjects(diff, @"\npath: .Optional\nleft: abc\nright: value is none\n");
}

@end
