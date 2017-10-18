//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

class MUSDateDiffer: MUSCustomDiffer {
    func match(left: Any, right: Any) -> Bool {
        return false
    }
    
    func diff(left: Any, right: Any, path: String?, delegatge: MUSDeepDiffProtocol) -> [MUSDifference] {
        return []
    }
}

/*
#import "MUSDateDiffer.h"
#import "MUSDifference.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MUSDateDiffer

- (Class)matchClass {
    return [NSDate class];
}

- (NSArray<MUSDifference *> *)diff:(id)left right:(id)right path:(nullable NSString *)path delegatge:(id<MUSDeepDiffProtocol>)delegate {
    if ([right isEqualToDate:left]) {
        return @[];
    } else {
        return @[[[MUSDifference alloc] initWithPath:path ?: @"date" left:[left debugDescription] right:[right debugDescription]]];
    }
}

@end

NS_ASSUME_NONNULL_END
*/

