//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import "MuscleAssert.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MuscleAssert

- (NSString *_Nullable)deepStricEqual:(id _Nullable)actual expected:(id _Nullable)expected message:(NSString *_Nullable)message {
    NSArray<MuscleAssertDifference *> *differences = [self diff:expected actual:actual path:nil];
    return [self format:message differences:differences];
}

- (NSArray<MuscleAssertDifference *> *)diff:expected actual:actual path:(NSString *_Nullable)path {
    if (expected == nil && actual == nil) {
        return @[];
    } else if (expected == nil || actual == nil) {
        return [self optionalDiff:expected actual:actual path:path];
    } else if ([expected isKindOfClass:[NSString class]] && [actual isKindOfClass:[NSString class]]) {
        return [self stringDiff:expected actual:actual path:path];
    } else if ([expected isKindOfClass:[NSDate class]] && [actual isKindOfClass:[NSDate class]]) {
        return [self dateDiff:expected actual:actual path:path];
    } else if ([expected isKindOfClass:[NSNumber class]] && [actual isKindOfClass:[NSNumber class]]) {
        return [self numberDiff:expected actual:actual path:path];
    } else if ([expected isKindOfClass:[NSDictionary class]] && [actual isKindOfClass:[NSDictionary class]]) {
        return [self dictionaryDiff:expected actual:actual path:path];
    } else if ([expected isKindOfClass:[NSArray class]] && [actual isKindOfClass:[NSArray class]]) {
        return [self arrayDiff:expected actual:actual path:path];
    } else if ([expected isKindOfClass:[actual class]]) {
        return [self sameTypeDiff:expected actual:actual path:path];
    } else {
        return [self diffarentTypeDiff:expected actual:actual path:path];
    }
}

- (NSArray<MuscleAssertDifference *> *)sameTypeDiff:(id)expected actual:(id)actual path:(NSString *_Nullable)path {
    if ([expected isEqual:actual]) {
        return @[];
    } else {
        return @[[[MuscleAssertDifference alloc] initWithPath:path ?: @"0" expected:[expected debugDescription] actual:[actual debugDescription]]];
    }
}

- (NSArray<MuscleAssertDifference *> *)diffarentTypeDiff:(id)expected actual:(id)actual path:(NSString *_Nullable)path {
    return @[[[MuscleAssertDifference alloc] initWithPath:path ?: @"0" expected:[expected debugDescription] actual:[actual debugDescription]]];
}

- (NSArray<MuscleAssertDifference *> *)stringDiff:(NSString *)expected actual:(NSString *)actual path:(NSString *_Nullable)path {
    NSArray *diff = [self lcsDiff:expected right:actual];
    NSInteger length = [diff count];
    
    NSMutableArray *result = [NSMutableArray array];
    for (NSInteger index = 0; index < length; index++) {
        [result addObject:[[MuscleAssertDifference alloc] initWithPath:[self pathByAppendingPath:path index:[diff[index][0] integerValue]] expected:diff[index][1] actual:diff[index][2]]];
    }
    return result;
}

- (NSString *)pathByAppendingPath:(NSString *)path index:(NSInteger)index {
    return path ? [path stringByAppendingFormat:@".%zd", index] : [NSString stringWithFormat:@"%zd", index];
}

- (NSArray<MuscleAssertDifference *> *)dateDiff:(NSDate *)expected actual:(NSDate *)actual path:(NSString *_Nullable)path {
    if ([expected isEqualToDate:actual]) {
        return @[];
    } else {
        return @[[[MuscleAssertDifference alloc] initWithPath:path ?: @"date" expected:[expected debugDescription] actual:[actual debugDescription]]];
    }
}

- (NSArray<MuscleAssertDifference *> *)numberDiff:(NSNumber *)expected actual:(NSNumber *)actual path:(NSString *_Nullable)path {
    if ([expected isEqualToNumber:actual]) {
        return @[];
    } else {
        return @[[[MuscleAssertDifference alloc] initWithPath:path ?: @"number" expected:[expected debugDescription] actual:[actual debugDescription]]];
    }
}

- (NSArray<MuscleAssertDifference *> *)optionalDiff:(id _Nullable)expected actual:(id _Nullable)actual path:(NSString *_Nullable)path {
    if (expected == nil && actual == nil) {
        return [self diff:expected actual:actual path:path];
    } else if (expected != nil) {
        return @[[[MuscleAssertDifference alloc] initWithPath:path ?: @"Optional" expected:[expected debugDescription] actual:@"value is none"]];
    } else if (actual != nil) {
        return @[[[MuscleAssertDifference alloc] initWithPath:path ?: @"Optional" expected:@"value is none" actual:[actual debugDescription]]];
    } else {
        return @[];
    }
}

- (NSArray<MuscleAssertDifference *> *)dictionaryDiff:(NSDictionary *)expected actual:(NSDictionary *)actual path:(NSString *_Nullable)path {
    NSSet *set = [NSSet setWithArray:[expected.allKeys arrayByAddingObjectsFromArray:actual.allKeys]];
    NSMutableArray *result = [NSMutableArray array];
    for (id key in set) {
        id expectedValue = expected[key];
        id actualValue = actual[key];
        [result addObjectsFromArray:[self diff:expectedValue actual:actualValue path:[key description]]];
    }
    return [result copy];
}

- (NSArray<MuscleAssertDifference *> *)arrayDiff:(NSArray *)expected actual:(NSArray *)actual path:(NSString *)path {
    NSInteger expectedLength = expected.count;
    NSInteger actualLength = actual.count;
    NSInteger length = MIN(expectedLength, actualLength);
    
    NSMutableArray *result = [NSMutableArray array];
    for (NSInteger index = 0; index < length; index++) {
        [result addObjectsFromArray:[self diff:expected[index] actual:actual[index] path:[self pathByAppendingPath:path index:index]]];
    }
    if (length < expectedLength) {
        [result addObject:[[MuscleAssertDifference alloc] initWithPath:[NSString stringWithFormat:@"%zd..<%zd", length, expectedLength] expected:[expected subarrayWithRange:NSMakeRange(length, expectedLength - length)] actual:@"too sort"]];
    } else if (length < actualLength) {
        [result addObject:[[MuscleAssertDifference alloc] initWithPath:[NSString stringWithFormat:@"%zd..<%zd", length, actualLength] expected:@"too sort" actual:[actual subarrayWithRange:NSMakeRange(length, actualLength - length)]]];
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
        text = [text stringByAppendingFormat:@"path: .%@\nactual: %@\nexpected: %@\n", diff.path, diff.actual, diff.expected];
    }
    return text;
}

@end

@implementation MuscleAssertDifference

- (instancetype)initWithPath:(NSString *)path expected:(NSString *)expected actual:(NSString *)actual {
    self = [super init];
    if (self) {
        _path = path;
        _expected = expected;
        _actual = actual;
    }
    return self;
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"MuscleAssertDifference(path: %@), expected: %@, actual: %@)", self.path, self.expected, self.actual];
}

@end

NS_ASSUME_NONNULL_END
