//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

class MUSDifferentTypeDiffer: MUSCustomDiffer {
    func match(left: Any, right: Any) -> Bool {
        return false
    }
    
    func diff(left: Any, right: Any, path: String?, delegatge: MUSDeepDiffProtocol) -> [MUSDifference] {
        return []
    }
}

/*
#import "MUSDifferentTypeDiffer.h"
#import "MUSDifference.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MUSDifferentTypeDiffer

- (BOOL)match:(id)left right:(id)right {
    return YES;
}

- (NSArray<MUSDifference *> *)diff:(id)left right:(id)right path:(nullable NSString *)path delegatge:(id<MUSDeepDiffProtocol>)delegate {
    return @[[[MUSDifference alloc] initWithPath:path ?: @"0" left:[left debugDescription] right:[right debugDescription]]];
}

@end

NS_ASSUME_NONNULL_END
*/

