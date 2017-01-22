//
//  DateTests.m
//  MuscleAssert
//
//  Created by akuraru on 2017/01/05.
//
//


#import <XCTest/XCTest.h>
#import "MuscleAssert.h"

@interface DateTests : XCTestCase
@property (nonatomic) MuscleAssert *assert;
@end

@implementation DateTests

- (void)setUp {
    [super setUp];
    self.assert = [[MuscleAssert alloc] init];
}

- (void)testEmpty {
    NSDate *date = [NSDate date];
    NSString *diff = [self.assert deepStricEqual:date right:date];
    XCTAssertNil(diff);
}

- (void)testEmptyRight {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:1481400000];
    NSDate *rightDate = [date dateByAddingTimeInterval:10];
    NSString *diff = [self.assert deepStricEqual:date right:rightDate];
    XCTAssertEqualObjects(diff, @"\npath: .date\n" "left: 2016-12-10 20:00:00 +0000\n" "right: 2016-12-10 20:00:10 +0000\n");
}

@end
