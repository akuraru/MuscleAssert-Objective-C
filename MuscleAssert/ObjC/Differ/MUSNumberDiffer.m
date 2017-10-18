//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import "MUSNumberDiffer.h"
#import "MUSDifference.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MUSNumberDiffer

- (Class)matchClass {
    return [NSNumber class];
}

- (NSArray<MUSDifference *> *)diff:(id)left right:(id)right path:(nullable NSString *)path delegatge:(id<MUSDeepDiffProtocol>)delegate {
    if ([right isEqualToNumber:left]) {
        return @[];
    } else {
        return @[[[MUSDifference alloc] initWithPath:path ?: @"number" left:[left debugDescription] right:[right debugDescription]]];
    }
}

@end

NS_ASSUME_NONNULL_END
