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
@property (nonatomic) NSArray<MUSCustomDiffer *> *lastDiffer;

@end

@implementation MuscleAssert

- (instancetype)init {
    self = [super init];
    if (self) {
        self.differ = [@[
                        [[MUSOptionalDiffer alloc] init],
                        [[MUSStringDiffer alloc] init],
                        [[MUSDateDiffer alloc] init],
                        [[MUSURLDiffer alloc] init],
                        [[MUSNumberDiffer alloc] init],
                        [[MUSDictionaryDiffer alloc] init],
                        [[MUSArrayDiffer alloc] init],
                        ] mutableCopy];
        self.lastDiffer = @[
                            [[MUSSameTypeDiffer alloc] init],
                            [[MUSDifferentTypeDiffer alloc] init]
                            ];
        self.formatter = [[MUSStandardFormatter alloc] init];
    }
    return self;
}

- (NSString *_Nullable)deepStricEqual:(id _Nullable)left right:(id _Nullable)right {
    return [self deepStricEqual:left right:right message:nil];
}

- (NSString *_Nullable)deepStricEqual:(id _Nullable)left right:(id _Nullable)right message:(NSString *_Nullable)message {
    NSArray<MUSDifference *> *differences = [self diff:right left:left path:nil];
    return [self.formatter format:message differences:differences];
}

- (NSArray<MUSDifference *> *)diff:right left:left path:(NSString *_Nullable)path {
    NSArray *differ = [[self differ] arrayByAddingObjectsFromArray:self.lastDiffer];
    for (MUSCustomDiffer *diff in differ) {
        if ([diff match:left right:right]) {
            return [diff diff:left right:right path:path delegatge:self];
        }
    }
    return differ;
}

- (void)cons:(MUSCustomDiffer *)differ {
    [self.differ insertObject:differ atIndex:0];
}

- (void)add:(MUSCustomDiffer *)differ {
    [self.differ addObject:differ];
}

@end

NS_ASSUME_NONNULL_END
