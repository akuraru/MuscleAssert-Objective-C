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
    NSString *diff = [self.assert deepStricEqual:url right:url];
    XCTAssertNil(diff);
}

- (void)testHttpsDiff {
    NSURL *leftUrl = [NSURL URLWithString:@"http://example.com"];
    NSURL *rightUrl = [NSURL URLWithString:@"https://example.com"];
    NSString *diff = [self.assert deepStricEqual:leftUrl right:rightUrl];
    XCTAssertEqualObjects(diff, @"\npath: .0\n" "left: http://example.com\n" "right: https://example.com\n");
}

@end
