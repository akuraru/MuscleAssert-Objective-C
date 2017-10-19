//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import "MUSDifference.h"

NS_ASSUME_NONNULL_BEGIN

@interface MUSDifference ()

@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *left;
@property (nonatomic, copy) NSString *right;

@end

@implementation MUSDifference

- (instancetype)initWithPath:(NSString *)path left:(NSString *)left right:(NSString *)right {
    self = [super init];
    
    self.path = path;
    self.left = left;
    self.right = right;
    
    return self;
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"MuscleAssertDifference(path: %@, left: %@, right: %@)", self.path, self.left, self.right];
}

@end

NS_ASSUME_NONNULL_END
