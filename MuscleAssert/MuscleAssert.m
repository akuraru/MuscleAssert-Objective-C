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
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface MuscleAssert ()

@property (nonatomic, copy) NSArray<MACustomDiff *> *differ;

@end

@implementation MuscleAssert

- (instancetype)init {
    self = [super init];
    if (self) {
        self.differ = @[
                        
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
            return [diff diff:left right:right path:path];
        }
    }
    if (right == nil && left == nil) {
        return @[];
    } else if (right == nil || left == nil) {
        return [self optionalDiff:right left:left path:path];
    } else if ([right isKindOfClass:[NSString class]] && [left isKindOfClass:[NSString class]]) {
        return [self stringDiff:right left:left path:path];
    } else if ([right isKindOfClass:[NSDate class]] && [left isKindOfClass:[NSDate class]]) {
        return [self dateDiff:right left:left path:path];
    } else if ([right isKindOfClass:[NSNumber class]] && [left isKindOfClass:[NSNumber class]]) {
        return [self numberDiff:right left:left path:path];
    } else if ([right isKindOfClass:[NSDictionary class]] && [left isKindOfClass:[NSDictionary class]]) {
        return [self dictionaryDiff:right left:left path:path];
    } else if ([right isKindOfClass:[NSArray class]] && [left isKindOfClass:[NSArray class]]) {
        return [self arrayDiff:right left:left path:path];
    } else if ([right isKindOfClass:[left class]]) {
        return [self sameTypeDiff:right left:left path:path];
    } else {
        return [self diffarentTypeDiff:right left:left path:path];
    }
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

- (NSArray<MuscleAssertDifference *> *)stringDiff:(NSString *)right left:(NSString *)left path:(NSString *_Nullable)path {
    NSArray *diff = [self lcsDiff:right right:left];
    NSInteger length = [diff count];
    
    NSMutableArray *result = [NSMutableArray array];
    for (NSInteger index = 0; index < length; index++) {
        [result addObject:[[MuscleAssertDifference alloc] initWithPath:[self pathByAppendingPath:path index:[diff[index][0] integerValue]]left:diff[index][2] right:diff[index][1] ]];
    }
    return result;
}

- (NSString *)pathByAppendingPath:(NSString *)path index:(NSInteger)index {
    return path ? [path stringByAppendingFormat:@".%zd", index] : [NSString stringWithFormat:@"%zd", index];
}

- (NSArray<MuscleAssertDifference *> *)dateDiff:(NSDate *)right left:(NSDate *)left path:(NSString *_Nullable)path {
    if ([right isEqualToDate:left]) {
        return @[];
    } else {
        return @[[[MuscleAssertDifference alloc] initWithPath:path ?: @"date" left:[left debugDescription] right:[right debugDescription]]];
    }
}

- (NSArray<MuscleAssertDifference *> *)numberDiff:(NSNumber *)right left:(NSNumber *)left path:(NSString *_Nullable)path {
    if ([right isEqualToNumber:left]) {
        return @[];
    } else {
        return @[[[MuscleAssertDifference alloc] initWithPath:path ?: @"number" left:[left debugDescription] right:[right debugDescription]]];
    }
}

- (NSArray<MuscleAssertDifference *> *)optionalDiff:(id _Nullable)right left:(id _Nullable)left path:(NSString *_Nullable)path {
    if (right == nil && left == nil) {
        return [self diff:right left:left path:path];
    } else if (right != nil) {
        return @[[[MuscleAssertDifference alloc] initWithPath:path ?: @"Optional" left:@"value is none" right:[right debugDescription]]];
    } else if (left != nil) {
        return @[[[MuscleAssertDifference alloc] initWithPath:path ?: @"Optional" left:[left debugDescription] right:@"value is none"]];
    } else {
        return @[];
    }
}

- (NSArray<MuscleAssertDifference *> *)dictionaryDiff:(NSDictionary *)right left:(NSDictionary *)left path:(NSString *_Nullable)path {
    NSSet *set = [NSSet setWithArray:[right.allKeys arrayByAddingObjectsFromArray:left.allKeys]];
    NSMutableArray *result = [NSMutableArray array];
    for (id key in set) {
        id rightValue = right[key];
        id leftValue = left[key];
        [result addObjectsFromArray:[self diff:rightValue left:leftValue path:[key description]]];
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

- (NSArray *)lcsDiff:(NSString *)left right:(NSString *)right {
    NSString *lcs = [self longestCommonSubsequence:left right:right];
    NSUInteger l1 = [left length];
    NSUInteger l2 = [right length];
    NSUInteger lc = [lcs length];
    NSUInteger idx1 = 0;
    NSUInteger idx2 = 0;
    NSUInteger idxc = 0;
    NSMutableString *s1 = [[NSMutableString alloc] initWithCapacity:l1];
    NSMutableString *s2 = [[NSMutableString alloc] initWithCapacity:l2];
    NSMutableArray *res = [NSMutableArray arrayWithCapacity:10];
    for (;;) {
        if (idxc >= lc) break;
        unichar c1 = [left characterAtIndex:idx1];
        unichar c2 = [right characterAtIndex:idx2];
        unichar cc = [lcs characterAtIndex:idxc];
        if ((c1 == cc) && (c2 == cc)) {
            if ([s1 length] || [s2 length]) {
                NSArray *e = @[@(idxc), s1, s2];
                [res addObject:e];
                s1 = [[NSMutableString alloc] initWithCapacity:l1];
                s2 = [[NSMutableString alloc] initWithCapacity:l1];
            }
            idx1++;
            idx2++;
            idxc++;
            continue;
        }
        if (c1 != cc) {
            [s1 appendString:[NSString stringWithCharacters:&c1 length:1]];
            idx1++;
        }
        if (c2 != cc) {
            [s2 appendString:[NSString stringWithCharacters:&c2 length:1]];
            idx2++;
        }
    }
    if (idx1 < l1) {
        [s1 appendString:[left substringFromIndex:idx1]];
    }
    if (idx2 < l2) {
        [s2 appendString:[right substringFromIndex:idx2]];
    }
    if ([s1 length] || [s2 length]) {
        NSArray *e = @[@(idxc), s1, s2];
        [res addObject:e];
    }
    return res;
}

- (NSString *)longestCommonSubsequence:(NSString *)left right:(NSString *)right {
    NSUInteger leftLength = left.length;
    NSUInteger rightLength = right.length;
    
    unsigned int **lengths = malloc((leftLength + 1) * sizeof(unsigned int *));
    
    for (unsigned int i = 0; i < (leftLength + 1); ++i) {
        lengths[i] = malloc((rightLength + 1) * sizeof(unsigned int));
        
        for (unsigned int j = 0; j < (rightLength + 1); ++j) {
            lengths[i][j] = 0;
        }
    }
    
    
    for (unsigned int i = 0; i < leftLength; ++i) {
        for (unsigned int j = 0; j < rightLength; ++j) {
            if ([left characterAtIndex:i] == [right characterAtIndex:j]) {
                lengths[i + 1][j + 1] = lengths[i][j] + 1;
            } else {
                lengths[i + 1][j + 1] = MAX(lengths[i + 1][j], lengths[i][j + 1]);
            }
        }
    }
    
    NSMutableString *lcs = [NSMutableString string];
    NSUInteger x = leftLength;
    NSUInteger y = rightLength;
    
    while (x != 0 && y != 0) {
        if (lengths[x][y] == lengths[x - 1][y]) {
            --x;
        } else if (lengths[x][y] == lengths[x][y - 1]) {
            --y;
        } else {
            [lcs appendFormat:@"%C", [left characterAtIndex:x - 1]];
            --x;
            --y;
        }
    }
    
    for (unsigned int i = 0; i < leftLength + 1; ++i) {
        free(lengths[i]);
    }
    
    free(lengths);
    
    NSMutableString *reversed = [NSMutableString stringWithCapacity:lcs.length];
    
    for (NSInteger i = lcs.length - 1; i >= 0; --i) {
        [reversed appendFormat:@"%C", [lcs characterAtIndex:i]];
    }
    
    return reversed;
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
