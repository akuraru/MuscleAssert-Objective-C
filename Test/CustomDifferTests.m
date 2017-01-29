//
//  CustomDifferTests.m
//  MuscleAssert
//
//  Created by akuraru on 2017/01/29.
//
//

#import <XCTest/XCTest.h>
#import "MuscleAssert.h"
#import "TestModel.h"
#import "MuscleAssertDifference.h"

@interface StringNumberDiffer : MACustomClassDiff
@end

@implementation StringNumberDiffer

- (BOOL)match:(id)left right:(id)right {
    return ([left isKindOfClass:[NSString class]] || [left isKindOfClass:[NSNumber class]])
    && ([right isKindOfClass:[NSString class]] || [right isKindOfClass:[NSNumber class]]);
}

- (NSArray<MuscleAssertDifference *> *)diff:(id)left right:(id)right path:(NSString *)path delegatge:(id<MSDeepDiffProtocol>)delegate {
    if ([left isKindOfClass:[NSNumber class]]) {
        left = [left stringValue];
    }
    if ([right isKindOfClass:[NSNumber class]]) {
        right = [right stringValue];
    }
    if ([left isEqualToString:right]) {
        return @[];
    } else {
        return @[[[MuscleAssertDifference alloc] initWithPath:path ?: @"" left:left right:right]];
    }
}

@end

@interface CustomDifferTests : XCTestCase
@property (nonatomic) MuscleAssert *assert;
@end

@implementation CustomDifferTests

- (void)setUp {
    [super setUp];
    self.assert = [[MuscleAssert alloc] init];
}

- (void)testCons {
    [self.assert cons:[[StringNumberDiffer alloc] init]];
    NSString *format = [self.assert deepStricEqual:@"1" right:@0];
    XCTAssertEqualObjects(format, @"\npath: .\n"
                          "  left: 1\n"
                          "  right: 0\n");
}

- (void)testAdd {
    [self.assert add:[[StringNumberDiffer alloc] init]];
    NSString *format = [self.assert deepStricEqual:@"1" right:@0];
    XCTAssertEqualObjects(format, @"\npath: .\n"
                          "  left: 1\n"
                          "  right: 0\n");
}

@end
