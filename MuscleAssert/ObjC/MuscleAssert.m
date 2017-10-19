//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import "MuscleAssert.h"
#import "MUSDifference.h"
#import "MUSCustomDiffer.h"
#import "MUSDiffer.h"
#import "MUSStandardFormatter.h"

NS_ASSUME_NONNULL_BEGIN

@interface MuscleAssert ()

@property (nonatomic) NSMutableArray<MUSCustomDiffer *> *differ;
@property (nonatomic) MUSSameTypeDiffer *sameTypeDiffer;
@property (nonatomic) MUSDifferentTypeDiffer *differentTypeDiffer;

@end

@implementation MuscleAssert

- (instancetype)init {
    self = [super init];
    
    self.differ = [@[
                     [[MUSOptionalDiffer alloc] init],
                     [[MUSStringDiffer alloc] init],
                     [[MUSDateDiffer alloc] init],
                     [[MUSURLDiffer alloc] init],
                     [[MUSNumberDiffer alloc] init],
                     [[MUSDictionaryDiffer alloc] init],
                     [[MUSArrayDiffer alloc] init],
                     ] mutableCopy];
    
    self.sameTypeDiffer = [[MUSSameTypeDiffer alloc] init];
    self.differentTypeDiffer = [[MUSDifferentTypeDiffer alloc] init];
    self.formatter = [[MUSStandardFormatter alloc] init];
    
    return self;
}

- (nullable NSString *)deepStricEqual:(nullable id)left right:(nullable id)right {
    return [self deepStricEqual:left right:right message:nil];
}

- (nullable NSString *)deepStricEqual:(nullable id)left right:(nullable id)right message:(nullable NSString *)message {
    NSArray<MUSDifference *> *differences = [self diff:right left:left path:nil];
    return [self.formatter format:message differences:differences];
}

- (NSArray<MUSDifference *> *)diff:right left:left path:(NSString *_Nullable)path {
    NSArray<MUSCustomDiffer *> *differ = [self differ];
    for (MUSCustomDiffer *diff in differ) {
        if ([diff match:left right:right]) {
            return [diff diff:left right:right path:path delegatge:self];
        }
    }
    if ([self.sameTypeDiffer match:left right:right]) {
        return [self.sameTypeDiffer diff:left right:right path:path delegatge:self];
    }
    return [self.differentTypeDiffer diff:left right:right path:path delegatge:self];
}

- (void)cons:(MUSCustomDiffer *)differ {
    [self.differ insertObject:differ atIndex:0];
}

- (void)add:(MUSCustomDiffer *)differ {
    [self.differ addObject:differ];
}

@end

NS_ASSUME_NONNULL_END
