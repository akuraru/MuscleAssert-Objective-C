//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import "MUSCustomDiffer.h"
#import "MUSDifference.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MUSCustomDiffer

- (BOOL)match:(id)left right:(id)right {
    return NO;
}

- (NSArray<MUSDifference *> *)diff:(id)left right:(id)right path:(nullable NSString *)path delegatge:(id<MUSDeepDiffProtocol>)delegate {
    return @[];
}

- (NSString *)pathByAppendingPath:(NSString *)path index:(NSInteger)index {
    return path ? [path stringByAppendingFormat:@".%zd", index] : [NSString stringWithFormat:@"%zd", index];
}

- (NSString *)pathByAppendingPath:(NSString *)path string:(NSString *)string {
    return path ? [path stringByAppendingFormat:@".%@", string] : string;
}

@end

@implementation MUSCustomClassDiffer

- (BOOL)match:(id)left right:(id)right {
    return [left isKindOfClass:self.matchClass] && [right isKindOfClass:self.matchClass];
}

@end

NS_ASSUME_NONNULL_END
