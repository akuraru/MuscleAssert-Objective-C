//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import "MUSURLDiffer.h"
#import "MUSDifference.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MUSURLDiffer

- (Class)matchClass {
    return [NSURL class];
}

- (NSArray<MUSDifference *> *)diff:(id)left right:(id)right path:(NSString *)path delegatge:(id<MUSDeepDiffProtocol>)delegate {
    if ([left isEqual:right]) {
        return @[];
    } else {
        NSString *nextPath = path ? [path stringByAppendingString:@".URL"] : @"URL";
        return @[[[MUSDifference alloc] initWithPath:nextPath left:[left absoluteString] right:[right absoluteString]]];
    }
}
@end

NS_ASSUME_NONNULL_END
