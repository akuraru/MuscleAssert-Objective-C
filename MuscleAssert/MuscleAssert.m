//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import "MuscleAssert.h"
#import "MuscleAssertDifference.h"
#import "MACustomDiff.h"
#import "MADiffer.h"
#import "MAStandardFormatter.h"

NS_ASSUME_NONNULL_BEGIN

@interface MuscleAssert ()

@property (nonatomic) NSMutableArray<MACustomDiff *> *differ;
@property (nonatomic) NSArray<MACustomDiff *> *lastDiffer;

@end

@implementation MuscleAssert

- (instancetype)init {
    self = [super init];
    if (self) {
        self.differ = [@[
                        [[MAOptionalDiffer alloc] init],
                        [[MAStringDiffer alloc] init],
                        [[MADateDiffer alloc] init],
                        [[MAURLDiffer alloc] init],
                        [[MANumberDiffer alloc] init],
                        [[MADictionaryDiffer alloc] init],
                        [[MAArrayDiffer alloc] init],
                        ] mutableCopy];
        self.lastDiffer = @[
                            [[MASameTypeDiffer alloc] init],
                            [[MADiffarentTypeDiffer alloc] init]
                            ];
        self.formatter = [[MAStandardFormatter alloc] init];
    }
    return self;
}

- (NSString *_Nullable)deepStricEqual:(id _Nullable)left right:(id _Nullable)right {
    return [self deepStricEqual:left right:right message:nil];
}

- (NSString *_Nullable)deepStricEqual:(id _Nullable)left right:(id _Nullable)right message:(NSString *_Nullable)message {
    NSArray<MuscleAssertDifference *> *differences = [self diff:right left:left path:nil];
    return [self.formatter format:message differences:differences];
}

- (NSArray<MuscleAssertDifference *> *)diff:right left:left path:(NSString *_Nullable)path {
    NSArray *differ = [[self differ] arrayByAddingObjectsFromArray:self.lastDiffer];
    for (MACustomDiff *diff in differ) {
        if ([diff match:left right:right]) {
            return [diff diff:left right:right path:path delegatge:self];
        }
    }
}

- (void)cons:(MACustomDiff *)differ {
    [self.differ insertObject:differ atIndex:0];
}

- (void)add:(MACustomDiff *)differ {
    [self.differ addObject:differ];
}

@end

NS_ASSUME_NONNULL_END
