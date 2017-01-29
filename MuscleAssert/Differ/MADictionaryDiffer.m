//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import "MADictionaryDiffer.h"
#import "MuscleAssertDifference.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MADictionaryDiffer

- (Class)matchClass {
    return [NSDictionary class];
}

- (NSArray<MuscleAssertDifference *> *)diff:(id)left right:(id)right path:(NSString *)path delegatge:(id<MSDeepDiffProtocol>)delegate {
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
