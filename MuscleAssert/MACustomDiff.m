//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import "MACustomDiff.h"
#import "MuscleAssertDifference.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MACustomDiff

- (BOOL)match:(id)left right:(id)right {
    return NO;
}

- (NSArray<MuscleAssertDifference *> *)diff:(id)left right:(id)right path:(NSString *)path {
    return @[];
}

- (NSString *)pathByAppendingPath:(NSString *)path index:(NSInteger)index {
    return path ? [path stringByAppendingFormat:@".%zd", index] : [NSString stringWithFormat:@"%zd", index];
}

@end

@interface MACustomClassDiff ()
@property (nonatomic, copy) Class class;
@end

@implementation MACustomClassDiff

- (BOOL)match:(id)left right:(id)right {
    return [left isKindOfClass:self.class] && [right isKindOfClass:self.class];
}

@end

NS_ASSUME_NONNULL_END
