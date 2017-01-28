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

@protocol MSDeepDiffProtocol <NSObject>
- (NSArray<MuscleAssertDifference *> *)diff:right left:left path:(NSString *_Nullable)path;
@end

@interface MACustomDiff : NSObject

- (BOOL)match:(id)left right:(id)right;
- (NSArray<MuscleAssertDifference *> *)diff:(id)left right:(id)right path:(NSString *)path delegatge:(id<MSDeepDiffProtocol>)delegate;

- (NSString *)pathByAppendingPath:(NSString *)path index:(NSInteger)index;

@end

@interface MACustomClassDiff : MACustomDiff
@property (nonatomic, readonly) Class matchClass;
@end

NS_ASSUME_NONNULL_END
