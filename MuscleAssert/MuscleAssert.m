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

- (NSString * _Nullable)deepStricEqual:(id _Nullable)actual expected:(id _Nullable)expected message:(NSString * _Nullable)message {
    NSArray<MuscleAssertDifference *> *differences = [self diff:expected actual:actual path:nil];
    return [self format:message differences:differences];
}

- (NSArray<MuscleAssertDifference *> *)diff:expected actual:actual path:(NSString * _Nullable)path {
    if (expected == nil && actual == nil) {
        return @[];
    } else if (expected == nil || actual == nil) {
        return [self optionalDiff:expected actual:actual path:path];
    } else if ([expected isKindOfClass:[NSString class]] && [actual isKindOfClass:[NSString class]]) {
        return [self stringDiff:expected actual:actual path:path];
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

- (NSArray<MuscleAssertDifference *> *)sameTypeDiff:(id)expected actual:(id)actual path:(NSString * _Nullable)path {
    if ([expected isEqual:actual]) {
        return @[];
    } else {
        return @[[[MuscleAssertDifference alloc] initWithPath:path ?: @"0" expected:[expected debugDescription] actual:[actual debugDescription]]];
    }
}

- (NSArray<MuscleAssertDifference *> *)diffarentTypeDiff:(id)expected actual:(id)actual path:(NSString * _Nullable)path {
    return @[[[MuscleAssertDifference alloc] initWithPath:path ?: @"0" expected:[expected debugDescription] actual:[actual debugDescription]]];
}

- (NSArray<MuscleAssertDifference *> *)stringDiff:(NSString *)expected actual:(NSString *)actual path:(NSString * _Nullable)path {
    NSInteger expectedLength = expected.length;
    NSInteger actualLength = actual.length;
    NSInteger length = MIN(expectedLength, actualLength);
    for (NSInteger index = 0; index < length; index++) {
        if ([expected characterAtIndex:index] != [actual characterAtIndex:index]) {
            return @[[[MuscleAssertDifference alloc] initWithPath:[self pathByAppendingPath:path index:index] expected:[expected substringFromIndex:index] actual:[actual substringFromIndex:index]]];
        }
    }
    if (expectedLength == actualLength) {
        return @[];
    } else if (length == expectedLength) {
        return @[[[MuscleAssertDifference alloc] initWithPath:[self pathByAppendingPath:path index:length] expected:@"" actual:[actual substringFromIndex:length]]];
    } else {
        return @[[[MuscleAssertDifference alloc] initWithPath:[self pathByAppendingPath:path index:length] expected: [expected substringFromIndex:length] actual:@""]];
    }
}

- (NSString *)pathByAppendingPath:(NSString *)path index:(NSInteger)index {
    return path ? [path stringByAppendingFormat:@".%zd", index] : [NSString stringWithFormat:@"%zd", index];
}

- (NSArray<MuscleAssertDifference *> *)optionalDiff:(id _Nullable)expected actual:(id _Nullable)actual path:(NSString * _Nullable)path {
    if (expected == nil && actual == nil) {
        return [self diff:expected actual:actual path:path];
    } else if (expected != nil) {
        return @[[[MuscleAssertDifference alloc] initWithPath:path ?: @"Optional"
                                                     expected:[expected debugDescription]
                                                       actual:@"value is none"]];
    } else if (actual != nil) {
        return @[[[MuscleAssertDifference alloc] initWithPath:path ?: @"Optional" expected: @"value is none" actual:[actual debugDescription]]];
    } else {
        return @[];
    }
}

- (NSArray<MuscleAssertDifference *> *)dictionaryDiff:(NSDictionary *)expected actual:(NSDictionary *)actual path:(NSString * _Nullable)path {
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
        [result addObject:[[MuscleAssertDifference alloc] initWithPath:[NSString stringWithFormat:@"%zd..<%zd", length, expectedLength] expected:[expected subarrayWithRange:NSMakeRange(length, expectedLength - length)] actual: @"too sort"]];
    } else if (length < actualLength) {
        [result addObject:[[MuscleAssertDifference alloc] initWithPath:[NSString stringWithFormat:@"%zd..<%zd", length, actualLength] expected:@"too sort" actual:[actual subarrayWithRange:NSMakeRange(length, actualLength - length)]]];
    }
    return result;
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
    return @"MuscleAssertDifference(path: \(path), expected: \(expected), actual: \(actual))";
}

@end

NS_ASSUME_NONNULL_END
