//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import "MANumberDiffer.h"
#import "MuscleAssertDifference.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MANumberDiffer

- (Class)class {
    return [NSNumber class];
}

- (NSArray<MuscleAssertDifference *> *)diff:(id)left right:(id)right path:(NSString *)path delegatge:(id<MSDeepDiffProtocol>)delegate {
    if ([right isEqualToNumber:left]) {
        return @[];
    } else {
        return @[[[MuscleAssertDifference alloc] initWithPath:path ?: @"number" left:[left debugDescription] right:[right debugDescription]]];
    }
}

@end

NS_ASSUME_NONNULL_END
