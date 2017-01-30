//
//  MuscleAssertOptionalTests.swift
//  MuscleAssert
//
//  Created by akuraru on 2017/01/02.
//
//

#import <XCTest/XCTest.h>
#import "MuscleAssert/MuscleAssert.h"

@interface OptionalTests : XCTestCase
@property (nonatomic) MuscleAssert *assert;
@end

@implementation OptionalTests

- (void)setUp {
    [super setUp];
    self.assert = [[MuscleAssert alloc] init];
}

- (void)testNone {
    NSString *diff = [self.assert deepStricEqual:nil right:nil];
    XCTAssertNil(diff);
}

- (void)testLeftNone {
    NSString *diff = [self.assert deepStricEqual:nil right:@"abc"];
    XCTAssertEqualObjects(diff, @"\npath: .Optional\n"
                          "  left: value is none\n"
                          "  right: abc\n");
}

- (void)testEmptyRight {
    NSString *diff = [self.assert deepStricEqual:@"abc" right:nil];
    XCTAssertEqualObjects(diff, @"\npath: .Optional\n"
                          "  left: abc\n"
                          "  right: value is none\n");
}

@end
