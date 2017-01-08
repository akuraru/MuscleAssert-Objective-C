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
    NSString *diff = [self.assert deepStricEqual:value expected:value message:@""];
    XCTAssertNil(diff);
}

- (void)testDiffRange {
    NSValue *actualValue = [NSValue valueWithRange:NSMakeRange(0, 1)];
    NSValue *expectedValue = [NSValue valueWithRange:NSMakeRange(2, 3)];
    NSString *diff = [self.assert deepStricEqual:actualValue expected:expectedValue message:@""];
    XCTAssertEqualObjects(diff, @"\n"
        "path: .0\nactual: NSRange: {0, 1}\nexpected: NSRange: {2, 3}\n"
    );
}

- (void)testEqualRect {
    NSValue *value = [NSValue valueWithCGRect:CGRectMake(0, 0, 0, 0)];
    NSString *diff = [self.assert deepStricEqual:value expected:value message:@""];
    XCTAssertNil(diff);
}

- (void)testDiffRect {
    NSValue *actualValue = [NSValue valueWithCGRect:CGRectMake(0, 1, 2, 3)];
    NSValue *expectedValue = [NSValue valueWithCGRect:CGRectMake(4, 5, 6, 7)];
    NSString *diff = [self.assert deepStricEqual:actualValue expected:expectedValue message:@""];
    XCTAssertEqualObjects(diff, @"\n"
        "path: .0\nactual: NSRect: {{0, 1}, {2, 3}}\nexpected: NSRect: {{4, 5}, {6, 7}}\n"
    );
}

- (void)testEqualSize {
    NSValue *value = [NSValue valueWithCGSize:CGSizeMake(0, 0)];
    NSString *diff = [self.assert deepStricEqual:value expected:value message:@""];
    XCTAssertNil(diff);
}

- (void)testDiffSize {
    NSValue *actualValue = [NSValue valueWithCGSize:CGSizeMake(0, 1)];
    NSValue *expectedValue = [NSValue valueWithCGSize:CGSizeMake(2, 3)];
    NSString *diff = [self.assert deepStricEqual:actualValue expected:expectedValue message:@""];
    XCTAssertEqualObjects(diff, @"\n"
        "path: .0\nactual: NSSize: {0, 1}\nexpected: NSSize: {2, 3}\n"
    );
}

- (void)testEqualPoint {
    NSValue *value = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    NSString *diff = [self.assert deepStricEqual:value expected:value message:@""];
    XCTAssertNil(diff);
}

- (void)testDiffPoint {
    NSValue *actualValue = [NSValue valueWithCGPoint:CGPointMake(0, 1)];
    NSValue *expectedValue = [NSValue valueWithCGPoint:CGPointMake(2, 3)];
    NSString *diff = [self.assert deepStricEqual:actualValue expected:expectedValue message:@""];
    XCTAssertEqualObjects(diff, @"\n"
        "path: .0\nactual: NSPoint: {0, 1}\nexpected: NSPoint: {2, 3}\n"
    );
}

- (void)testDiffRangeAndRect {
    NSValue *actualValue = [NSValue valueWithRange:NSMakeRange(0, 1)];
    NSValue *expectedValue = [NSValue valueWithCGRect:CGRectMake(5, 6, 7, 8)];
    NSString *diff = [self.assert deepStricEqual:actualValue expected:expectedValue message:@""];
    XCTAssertEqualObjects(diff, @"\n"
        "path: .0\nactual: NSRange: {0, 1}\nexpected: NSRect: {{5, 6}, {7, 8}}\n"
    );
}

- (void)testDiffRangeAndSize {
    NSValue *actualValue = [NSValue valueWithRange:NSMakeRange(0, 1)];
    NSValue *expectedValue = [NSValue valueWithCGSize:CGSizeMake(0, 1)];
    NSString *diff = [self.assert deepStricEqual:actualValue expected:expectedValue message:@""];
    XCTAssertEqualObjects(diff, @"\n"
        "path: .0\nactual: NSRange: {0, 1}\nexpected: NSSize: {0, 1}\n"
    );
}

- (void)testDiffRangeAndPoint {
    NSValue *actualValue = [NSValue valueWithRange:NSMakeRange(0, 1)];
    NSValue *expectedValue = [NSValue valueWithCGPoint:CGPointMake(0, 1)];
    NSString *diff = [self.assert deepStricEqual:actualValue expected:expectedValue message:@""];
    XCTAssertEqualObjects(diff, @"\n"
        "path: .0\nactual: NSRange: {0, 1}\nexpected: NSPoint: {0, 1}\n"
    );
}

- (void)testDiffRectAndSize {
    NSValue *actualValue = [NSValue valueWithCGRect:CGRectMake(5, 6, 7, 8)];
    NSValue *expectedValue = [NSValue valueWithCGSize:CGSizeMake(0, 1)];
    NSString *diff = [self.assert deepStricEqual:actualValue expected:expectedValue message:@""];
    XCTAssertEqualObjects(diff, @"\n"
        "path: .0\nactual: NSRect: {{5, 6}, {7, 8}}\nexpected: NSSize: {0, 1}\n"
    );
}

- (void)testDiffRectAndPoint {
    NSValue *actualValue = [NSValue valueWithCGRect:CGRectMake(5, 6, 7, 8)];
    NSValue *expectedValue = [NSValue valueWithCGPoint:CGPointMake(0, 1)];
    NSString *diff = [self.assert deepStricEqual:actualValue expected:expectedValue message:@""];
    XCTAssertEqualObjects(diff, @"\n"
        "path: .0\nactual: NSRect: {{5, 6}, {7, 8}}\nexpected: NSPoint: {0, 1}\n"
    );
}

- (void)testDiffSizeAndPoint {
    NSValue *actualValue = [NSValue valueWithCGSize:CGSizeMake(0, 1)];
    NSValue *expectedValue = [NSValue valueWithCGPoint:CGPointMake(0, 1)];
    NSString *diff = [self.assert deepStricEqual:actualValue expected:expectedValue message:@""];
    XCTAssertEqualObjects(diff, @"\n"
        "path: .0\nactual: NSSize: {0, 1}\nexpected: NSPoint: {0, 1}\n"
    );
}

@end
