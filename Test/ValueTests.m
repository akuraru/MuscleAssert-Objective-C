//
//  ValueTests.m
//  MuscleAssert
//
//  Created by akuraru on 2017/01/08.
//
//

#import <XCTest/XCTest.h>
#import "MuscleAssert.h"

@interface ValueTests : XCTestCase
@property (nonatomic) MuscleAssert *assert;
@end

@implementation ValueTests

- (void)setUp {
    [super setUp];
    self.assert = [[MuscleAssert alloc] init];
    self.assert.deepSearch = YES;
}

- (void)testEqualRange {
    NSValue *value = [NSValue valueWithRange:NSMakeRange(0, 0)];
    NSString *diff = [self.assert deepStricEqual:value right:value];
    XCTAssertNil(diff);
}

- (void)testDiffRange {
    NSValue *leftValue = [NSValue valueWithRange:NSMakeRange(0, 1)];
    NSValue *rightValue = [NSValue valueWithRange:NSMakeRange(2, 3)];
    NSString *diff = [self.assert deepStricEqual:leftValue right:rightValue];
    XCTAssertEqualObjects(diff, @"\n"
        "path: .0\nleft: NSRange: {0, 1}\nright: NSRange: {2, 3}\n"
    );
}

- (void)testEqualRect {
    NSValue *value = [NSValue valueWithCGRect:CGRectMake(0, 0, 0, 0)];
    NSString *diff = [self.assert deepStricEqual:value right:value];
    XCTAssertNil(diff);
}

- (void)testDiffRect {
    NSValue *leftValue = [NSValue valueWithCGRect:CGRectMake(0, 1, 2, 3)];
    NSValue *rightValue = [NSValue valueWithCGRect:CGRectMake(4, 5, 6, 7)];
    NSString *diff = [self.assert deepStricEqual:leftValue right:rightValue];
    XCTAssertEqualObjects(diff, @"\n"
        "path: .0\nleft: NSRect: {{0, 1}, {2, 3}}\nright: NSRect: {{4, 5}, {6, 7}}\n"
    );
}

- (void)testEqualSize {
    NSValue *value = [NSValue valueWithCGSize:CGSizeMake(0, 0)];
    NSString *diff = [self.assert deepStricEqual:value right:value];
    XCTAssertNil(diff);
}

- (void)testDiffSize {
    NSValue *leftValue = [NSValue valueWithCGSize:CGSizeMake(0, 1)];
    NSValue *rightValue = [NSValue valueWithCGSize:CGSizeMake(2, 3)];
    NSString *diff = [self.assert deepStricEqual:leftValue right:rightValue];
    XCTAssertEqualObjects(diff, @"\n"
        "path: .0\nleft: NSSize: {0, 1}\nright: NSSize: {2, 3}\n"
    );
}

- (void)testEqualPoint {
    NSValue *value = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    NSString *diff = [self.assert deepStricEqual:value right:value];
    XCTAssertNil(diff);
}

- (void)testDiffPoint {
    NSValue *leftValue = [NSValue valueWithCGPoint:CGPointMake(0, 1)];
    NSValue *rightValue = [NSValue valueWithCGPoint:CGPointMake(2, 3)];
    NSString *diff = [self.assert deepStricEqual:leftValue right:rightValue];
    XCTAssertEqualObjects(diff, @"\n"
        "path: .0\nleft: NSPoint: {0, 1}\nright: NSPoint: {2, 3}\n"
    );
}

- (void)testDiffRangeAndRect {
    NSValue *leftValue = [NSValue valueWithRange:NSMakeRange(0, 1)];
    NSValue *rightValue = [NSValue valueWithCGRect:CGRectMake(5, 6, 7, 8)];
    NSString *diff = [self.assert deepStricEqual:leftValue right:rightValue];
    XCTAssertEqualObjects(diff, @"\n"
        "path: .0\nleft: NSRange: {0, 1}\nright: NSRect: {{5, 6}, {7, 8}}\n"
    );
}

- (void)testDiffRangeAndSize {
    NSValue *leftValue = [NSValue valueWithRange:NSMakeRange(0, 1)];
    NSValue *rightValue = [NSValue valueWithCGSize:CGSizeMake(0, 1)];
    NSString *diff = [self.assert deepStricEqual:leftValue right:rightValue];
    XCTAssertEqualObjects(diff, @"\n"
        "path: .0\nleft: NSRange: {0, 1}\nright: NSSize: {0, 1}\n"
    );
}

- (void)testDiffRangeAndPoint {
    NSValue *leftValue = [NSValue valueWithRange:NSMakeRange(0, 1)];
    NSValue *rightValue = [NSValue valueWithCGPoint:CGPointMake(0, 1)];
    NSString *diff = [self.assert deepStricEqual:leftValue right:rightValue];
    XCTAssertEqualObjects(diff, @"\n"
        "path: .0\nleft: NSRange: {0, 1}\nright: NSPoint: {0, 1}\n"
    );
}

- (void)testDiffRectAndSize {
    NSValue *leftValue = [NSValue valueWithCGRect:CGRectMake(5, 6, 7, 8)];
    NSValue *rightValue = [NSValue valueWithCGSize:CGSizeMake(0, 1)];
    NSString *diff = [self.assert deepStricEqual:leftValue right:rightValue];
    XCTAssertEqualObjects(diff, @"\n"
        "path: .0\nleft: NSRect: {{5, 6}, {7, 8}}\nright: NSSize: {0, 1}\n"
    );
}

- (void)testDiffRectAndPoint {
    NSValue *leftValue = [NSValue valueWithCGRect:CGRectMake(5, 6, 7, 8)];
    NSValue *rightValue = [NSValue valueWithCGPoint:CGPointMake(0, 1)];
    NSString *diff = [self.assert deepStricEqual:leftValue right:rightValue];
    XCTAssertEqualObjects(diff, @"\n"
        "path: .0\nleft: NSRect: {{5, 6}, {7, 8}}\nright: NSPoint: {0, 1}\n"
    );
}

- (void)testDiffSizeAndPoint {
    NSValue *leftValue = [NSValue valueWithCGSize:CGSizeMake(0, 1)];
    NSValue *rightValue = [NSValue valueWithCGPoint:CGPointMake(0, 1)];
    NSString *diff = [self.assert deepStricEqual:leftValue right:rightValue];
    XCTAssertEqualObjects(diff, @"\n"
        "path: .0\nleft: NSSize: {0, 1}\nright: NSPoint: {0, 1}\n"
    );
}

@end
