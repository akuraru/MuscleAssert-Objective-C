//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MuscleAssert: NSObject

- (NSString * _Nullable)deepStricEqual:(id)actual expected:(id)expected message:(NSString * _Nullable)message;

@end

@interface MuscleAssertDifference: NSObject

@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *expected;
@property (nonatomic, copy) NSString *actual;

- (instancetype)initWithPath:(NSString *)path expected:(NSString *)expected actual:(NSString *)actual;

@end

NS_ASSUME_NONNULL_END
