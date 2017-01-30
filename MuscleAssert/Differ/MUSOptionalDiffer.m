//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import "MUSOptionalDiffer.h"
#import "MUSDifference.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MUSOptionalDiffer

- (BOOL)match:(id)left right:(id)right {
    return left == nil || right == nil;
}

- (NSArray<MUSDifference *> *)diff:(id)left right:(id)right path:(NSString *)path delegatge:(id<MUSDeepDiffProtocol>)delegate {
    if (right == nil && left == nil) {
        return @[];
    } else if (right != nil) {
        return @[[[MUSDifference alloc] initWithPath:path ?: @"Optional" left:@"value is none" right:[right debugDescription]]];
    } else {
        return @[[[MUSDifference alloc] initWithPath:path ?: @"Optional" left:[left debugDescription] right:@"value is none"]];
    }
}

@end

NS_ASSUME_NONNULL_END
