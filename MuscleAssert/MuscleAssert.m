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

NS_ASSUME_NONNULL_BEGIN

@interface MuscleAssert () <MSDeepDiffProtocol>

@property (nonatomic, copy) NSArray<MACustomDiff *> *differ;

@end

@implementation MuscleAssert

- (instancetype)init {
    self = [super init];
    if (self) {
        self.differ = @[
                        [[MAOptionalDiffer alloc] init],
                        [[MAStringDiffer alloc] init],
                        [[MADateDiffer alloc] init],
                        [[MAURLDiffer alloc] init],
                        [[MANumberDiffer alloc] init],
                        [[MADictionaryDiffer alloc] init],
                        [[MAArrayDiffer alloc] init],
                        [[MASameTypeDiffer alloc] init],
                        ];
    }
    return self;
}

- (NSString *_Nullable)deepStricEqual:(id _Nullable)left right:(id _Nullable)right {
    return [self deepStricEqual:left right:right message:nil];
}

- (NSString *_Nullable)deepStricEqual:(id _Nullable)left right:(id _Nullable)right message:(NSString *_Nullable)message {
    NSArray<MuscleAssertDifference *> *differences = [self diff:right left:left path:nil];
    return [self format:message differences:differences];
}

- (NSArray<MuscleAssertDifference *> *)diff:right left:left path:(NSString *_Nullable)path {
    for (MACustomDiff *diff in self.differ) {
        if ([diff match:left right:right]) {
            return [diff diff:left right:right path:path delegatge:self];
        }
    }
    
    return [self diffarentTypeDiff:right left:left path:path];
}

- (NSArray<MuscleAssertDifference *> *)diffarentTypeDiff:(id)right left:(id)left path:(NSString *_Nullable)path {
    return @[[[MuscleAssertDifference alloc] initWithPath:path ?: @"0" left:[left debugDescription] right:[right debugDescription]]];
}

- (NSString *)pathByAppendingPath:(NSString *)path index:(NSInteger)index {
    return path ? [path stringByAppendingFormat:@".%zd", index] : [NSString stringWithFormat:@"%zd", index];
}

- (NSString *)format:(NSString *)message differences:(NSArray<MuscleAssertDifference *> *)differences {
    if ([differences count] == 0) {
        return nil;
    }
    NSString *text = (message != nil) ? [message stringByAppendingString:@"\n"] : @"\n";
    for (MuscleAssertDifference *diff in differences) {
        text = [text stringByAppendingFormat:@"path: .%@\n  left: %@\n  right: %@\n", diff.path, diff.left, diff.right];
    }
    return text;
}

@end

NS_ASSUME_NONNULL_END
