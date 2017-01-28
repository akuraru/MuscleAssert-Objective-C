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
#import <objc/runtime.h>

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
                        [[MANumberDiffer alloc] init],
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
    
    if ([right isKindOfClass:[NSDictionary class]] && [left isKindOfClass:[NSDictionary class]]) {
        return [self dictionaryDiff:right left:left path:path];
    }
    if ([right isKindOfClass:[NSArray class]] && [left isKindOfClass:[NSArray class]]) {
        return [self arrayDiff:right left:left path:path];
    }
    if ([right isKindOfClass:[left class]]) {
        return [self sameTypeDiff:right left:left path:path];
    }
    return [self diffarentTypeDiff:right left:left path:path];
}

- (NSArray<MuscleAssertDifference *> *)sameTypeDiff:(id)right left:(id)left path:(NSString *_Nullable)path {
    if ([right isEqual:left]) {
        return @[];
    } else {
        NSArray<NSString *> *propertyNames = [self propertyNames:right];
        if (!self.deepSearch || propertyNames.count == 0) {
            return @[[[MuscleAssertDifference alloc] initWithPath:path ?: @"0" left:[left debugDescription] right:[right debugDescription]]];
        } else {
            NSMutableArray *results = [NSMutableArray array];
            for (NSString *propertyName in propertyNames) {
                [results addObjectsFromArray:[self diff:[right performSelector:NSSelectorFromString(propertyName)] left:[left performSelector:NSSelectorFromString(propertyName)] path:propertyName]];
            }
            return results;
        }
    }
}

- (NSArray<NSString *> *)propertyNames:(id)object {
    NSMutableArray *propertyNames = [NSMutableArray array];
    
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([object class], &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if (propName) {
            NSString *propertyName = [NSString stringWithCString:propName encoding:[NSString defaultCStringEncoding]];
            [propertyNames addObject:propertyName];
        }
    }
    free(properties);
    return propertyNames;
}

- (NSArray<MuscleAssertDifference *> *)diffarentTypeDiff:(id)right left:(id)left path:(NSString *_Nullable)path {
    return @[[[MuscleAssertDifference alloc] initWithPath:path ?: @"0" left:[left debugDescription] right:[right debugDescription]]];
}

- (NSString *)pathByAppendingPath:(NSString *)path index:(NSInteger)index {
    return path ? [path stringByAppendingFormat:@".%zd", index] : [NSString stringWithFormat:@"%zd", index];
}

- (NSArray<MuscleAssertDifference *> *)dictionaryDiff:(NSDictionary *)right left:(NSDictionary *)left path:(NSString *_Nullable)path {
    NSSet *set = [NSSet setWithArray:[right.allKeys arrayByAddingObjectsFromArray:left.allKeys]];
    NSMutableArray *result = [NSMutableArray array];
    for (id key in set) {
        id rightValue = right[key];
        id leftValue = left[key];
        NSString *nextPath = path ? [path stringByAppendingFormat:@".%@", [key description]] : [key description];
        [result addObjectsFromArray:[self diff:rightValue left:leftValue path:nextPath]];
    }
    return [result copy];
}

- (NSArray<MuscleAssertDifference *> *)arrayDiff:(NSArray *)right left:(NSArray *)left path:(NSString *)path {
    NSInteger rightLength = right.count;
    NSInteger leftLength = left.count;
    NSInteger length = MIN(rightLength, leftLength);
    
    NSMutableArray *result = [NSMutableArray array];
    for (NSInteger index = 0; index < length; index++) {
        [result addObjectsFromArray:[self diff:right[index] left:left[index] path:[self pathByAppendingPath:path index:index]]];
    }
    if (length < rightLength) {
        [result addObject:[[MuscleAssertDifference alloc] initWithPath:[NSString stringWithFormat:@"%zd..<%zd", length, rightLength] left:@"too sort" right:[right subarrayWithRange:NSMakeRange(length, rightLength - length)]]];
    } else if (length < leftLength) {
        [result addObject:[[MuscleAssertDifference alloc] initWithPath:[NSString stringWithFormat:@"%zd..<%zd", length, leftLength] left:[left subarrayWithRange:NSMakeRange(length, leftLength - length)] right:@"too sort"]];
    }
    return result;
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
