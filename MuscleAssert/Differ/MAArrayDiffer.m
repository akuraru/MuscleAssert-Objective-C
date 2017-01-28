//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import "MAArrayDiffer.h"
#import "MuscleAssertDifference.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MAArrayDiffer

- (Class)class {
    return [NSArray class];
}

- (NSArray<MuscleAssertDifference *> *)diff:(id)left right:(id)right path:(NSString *)path delegatge:(id<MSDeepDiffProtocol>)delegate {
    NSInteger rightLength = [right count];
    NSInteger leftLength = [left count];
    NSInteger length = MIN(rightLength, leftLength);
    
    NSMutableArray *result = [NSMutableArray array];
    for (NSInteger index = 0; index < length; index++) {
        [result addObjectsFromArray:[delegate diff:right[index] left:left[index] path:[self pathByAppendingPath:path index:index]]];
    }
    if (length < rightLength) {
        [result addObject:[[MuscleAssertDifference alloc] initWithPath:[NSString stringWithFormat:@"%zd..<%zd", length, rightLength] left:@"too sort" right:[right subarrayWithRange:NSMakeRange(length, rightLength - length)]]];
    } else if (length < leftLength) {
        [result addObject:[[MuscleAssertDifference alloc] initWithPath:[NSString stringWithFormat:@"%zd..<%zd", length, leftLength] left:[left subarrayWithRange:NSMakeRange(length, leftLength - length)] right:@"too sort"]];
    }
    return result;
}

@end

NS_ASSUME_NONNULL_END
