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

@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *left;
@property (nonatomic, copy) NSString *right;

- (instancetype)initWithPath:(NSString *)path left:(NSString *)left right:(NSString *)right;

@end

NS_ASSUME_NONNULL_END
