//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MUSDifference;

@protocol MUSDeepDiffProtocol <NSObject>
- (NSArray<MUSDifference *> *)diff:right left:left path:(NSString *_Nullable)path;
@end

@interface MUSCustomDiffer : NSObject

- (BOOL)match:(id)left right:(id)right;
- (NSArray<MUSDifference *> *)diff:(id)left right:(id)right path:(NSString *)path delegatge:(id<MUSDeepDiffProtocol>)delegate;

- (NSString *)pathByAppendingPath:(NSString *)path index:(NSInteger)index;
- (NSString *)pathByAppendingPath:(NSString *)path string:(NSString *)string;

@end

@interface MUSCustomClassDiffer : MUSCustomDiffer
@property (nonatomic, readonly) Class matchClass;
@end

NS_ASSUME_NONNULL_END
