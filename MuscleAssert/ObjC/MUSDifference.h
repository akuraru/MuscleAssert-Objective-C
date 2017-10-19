//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MUSDifference : NSObject

@property (nonatomic, copy, readonly) NSString *path;
@property (nonatomic, copy, readonly) NSString *left;
@property (nonatomic, copy, readonly) NSString *right;

- (instancetype)initWithPath:(NSString *)path left:(NSString *)left right:(NSString *)right;

@end

NS_ASSUME_NONNULL_END
