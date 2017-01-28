//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import "MAURLDiffer.h"
#import "MuscleAssertDifference.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MAURLDiffer

- (Class)class {
    return [NSURL class];
}

- (NSArray<MuscleAssertDifference *> *)diff:(id)left right:(id)right path:(NSString *)path delegatge:(id<MSDeepDiffProtocol>)delegate {
    if ([left isEqual:right]) {
        return @[];
    } else {
        NSString *nextPath = path ? [path stringByAppendingString:@".URL"] : @"URL";
        return @[[[MuscleAssertDifference alloc] initWithPath:nextPath left:[left absoluteString] right:[right absoluteString]]];
    }
}
@end

NS_ASSUME_NONNULL_END
