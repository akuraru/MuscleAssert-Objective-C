//
//  URLTests.m
//  MuscleAssert
//
//  Created by akuraru on 2017/01/08.
//
//

#import <XCTest/XCTest.h>
#import "MuscleAssert.h"

@interface URLTests : XCTestCase
@property (nonatomic) MuscleAssert *assert;
@end

@implementation URLTests

- (void)setUp {
    [super setUp];
    self.assert = [[MuscleAssert alloc] init];
}

- (void)testSame {
    NSURL *url = [NSURL URLWithString:@"http://example.com"];
    NSString *diff = [self.assert deepStricEqual:url expected:url message:@""];
    XCTAssertNil(diff);
}

- (void)testHttpsDiff {
    NSURL *actualUrl = [NSURL URLWithString:@"http://example.com"];
    NSURL *expectedUrl = [NSURL URLWithString:@"https://example.com"];
    NSString *diff = [self.assert deepStricEqual:actualUrl expected:expectedUrl message:@""];
    XCTAssertEqualObjects(diff, @"\npath: .0\n" "actual: http://example.com\n" "expected: https://example.com\n");
}

@end
