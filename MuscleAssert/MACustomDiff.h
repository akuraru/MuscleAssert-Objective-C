//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MuscleAssertDifference;

@interface MACustomDiff : NSObject

- (BOOL)match:(id)left right:(id)right;
- (NSArray<MuscleAssertDifference *> *)diff:(id)left right:(id)right path:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
