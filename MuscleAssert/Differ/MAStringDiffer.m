//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import "MAStringDiffer.h"
#import "MuscleAssertDifference.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MAStringDiffer

- (Class)class {
    return [NSString class];
}

- (NSArray<MuscleAssertDifference *> *)diff:(id)left right:(id)right path:(NSString *)path delegatge:(id<MSDeepDiffProtocol>)delegate {
    return [self stringDiff:right left:left path:path];
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

@end

NS_ASSUME_NONNULL_END
