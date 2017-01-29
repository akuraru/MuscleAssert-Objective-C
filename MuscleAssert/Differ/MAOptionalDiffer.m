//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import "MAOptionalDiffer.h"
#import "MuscleAssertDifference.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MAOptionalDiffer

- (BOOL)match:(id)left right:(id)right {
    return left == nil || right == nil;
}

- (NSArray<MuscleAssertDifference *> *)diff:(id)left right:(id)right path:(NSString *)path delegatge:(id<MSDeepDiffProtocol>)delegate {
    if (right == nil && left == nil) {
        return @[];
    } else if (right != nil) {
        return @[[[MuscleAssertDifference alloc] initWithPath:path ?: @"Optional" left:@"value is none" right:[right debugDescription]]];
    } else {
        return @[[[MuscleAssertDifference alloc] initWithPath:path ?: @"Optional" left:[left debugDescription] right:@"value is none"]];
    }
}

@end

NS_ASSUME_NONNULL_END
