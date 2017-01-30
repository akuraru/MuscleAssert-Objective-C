//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import "MUSDictionaryDiffer.h"
#import "MUSDifference.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MUSDictionaryDiffer

- (Class)matchClass {
    return [NSDictionary class];
}

- (NSArray<MUSDifference *> *)diff:(id)left right:(id)right path:(NSString *)path delegatge:(id<MUSDeepDiffProtocol>)delegate {
    NSSet *set = [NSSet setWithArray:[[right allKeys] arrayByAddingObjectsFromArray:[left allKeys]]];
    NSMutableArray *result = [NSMutableArray array];
    for (id key in set) {
        id rightValue = right[key];
        id leftValue = left[key];
        NSString *nextPath = path ? [path stringByAppendingFormat:@".%@", [key description]] : [key description];
        [result addObjectsFromArray:[delegate diff:rightValue left:leftValue path:nextPath]];
    }
    return [result copy];
}

@end

NS_ASSUME_NONNULL_END
