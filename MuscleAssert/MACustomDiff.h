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

@property (nonatomic, copy) BOOL(^match)(id, id);
@property (nonatomic, copy) NSArray<MuscleAssertDifference *> *(^diff)(id, id);

- (instancetype)initWithMatch:(BOOL(^)(id, id))match diff:(NSArray<MuscleAssertDifference *> *(^)(id, id))diff;

@end

NS_ASSUME_NONNULL_END
