//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import "MADiffarentTypeDiffer.h"
#import "MuscleAssertDifference.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MADiffarentTypeDiffer

- (BOOL)match:(id)left right:(id)right {
    return YES;
}

- (NSArray<MuscleAssertDifference *> *)diff:(id)left right:(id)right path:(NSString *)path delegatge:(id<MSDeepDiffProtocol>)delegate {
    return @[[[MuscleAssertDifference alloc] initWithPath:path ?: @"0" left:[left debugDescription] right:[right debugDescription]]];
}

@end

NS_ASSUME_NONNULL_END
