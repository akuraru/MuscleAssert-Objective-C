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

- (NSString * _Nullable)deepStricEqual:(id)actual expected:(id)expected message:(NSString * _Nullable)message {
    if (![self deepEqual:actual expected:expected]) {
        MuscleAssertDifference *differences = [self diff:expected actual:actual];
        return [self format:message differences:differences];
    }
    return nil;
}
- (BOOL)deepEqual:actual expected:expected {
        if ([actual isEqual:expected]) {
        return YES;
    }
    return NO;
}
- (NSArray<MuscleAssertDifference *> *)diff:expected actual:actual {
    if ([expected isKindOfClass:[NSString class]] && [actual isKindOfClass:[NSString class]]) {
        return [self stringDiff:expected actual:actual];
    }
    return @[];
//    switch (expected, actual) {
//        case let (e as [T], a as [T]):
//            return diff(expected: e, actual: a)
//        case let (e as String, a as String):
//            return diff(expected: e, actual: a)
//        case let (e, a) where e != a:
//            return [MuscleAssertDifference(
//                path: "0",
//                expected: expected.debugDescription,
//                actual: actual.debugDescription
//                )]
//        default:
//            return []
//        }
}
//    class func diff(expected: String, actual: String) -> [MuscleAssertDifference] {
//        return diff(expected: expected as NSString, actual: actual as NSString)
//    }
- (NSArray<MuscleAssertDifference *> *)stringDiff:(NSString *)expected actual:(NSString *)actual {
    NSInteger expectedLength = expected.length;
    NSInteger actualLength = actual.length;
    NSInteger length = MIN(expectedLength, actualLength);
    for (NSInteger index = 0; index < length; index++) {
        if ([expected characterAtIndex:index] != [actual characterAtIndex:index]) {
            return @[[[MuscleAssertDifference alloc] initWithPath:[NSString stringWithFormat:@"%zd", index] expected: [expected substringFromIndex:index] actual:[actual substringFromIndex:index]]];
        }
    }
    if (expectedLength == actualLength) {
        return @[];
    } else if (length == expectedLength) {
        return @[[[MuscleAssertDifference alloc] initWithPath:[NSString stringWithFormat:@"%zd", length] expected: @"" actual:[actual substringFromIndex:length]]];
    } else {
        return @[[[MuscleAssertDifference alloc] initWithPath:[NSString stringWithFormat:@"%zd", length] expected: [expected substringFromIndex:length] actual:@""]];
        }
    }
//    public class func diff<T>(expected: T?, actual: T?) -> [MuscleAssertDifference] where T: Equatable, T: CustomDebugStringConvertible {
//        if let expected = expected, let actual = actual {
//            return diff(expected: expected, actual: actual)
//        } else if let expected = expected {
//            return [MuscleAssertDifference(
//                path: "Optional",
//                expected: expected.debugDescription,
//                actual: "value is nooe"
//                )]
//        } else if let actual = actual {
//            return [MuscleAssertDifference(
//                path: "Optional",
//                expected: "value is none",
//                actual: actual.debugDescription
//                )]
//        } else {
//            return []
//        }
//    }
//    public class func diff<T, U: Equatable>(expected: [T: U], actual: [T: U]) -> [MuscleAssertDifference] where T: CustomDebugStringConvertible, U: CustomDebugStringConvertible {
//        let set = Set(Array(expected.keys) + Array(actual.keys))
//        return set.flatMap { (key) in
//            let expectedValue = expected[key]
//            let actualValue = actual[key]
//            if expectedValue == nil, let actualValue = actualValue {
//                return MuscleAssertDifference(
//                    path: "\(key)",
//                    expected: "value is none",
//                    actual: actualValue.debugDescription
//                )
//            } else if actualValue == nil, let expectedValue = expectedValue {
//                return MuscleAssertDifference(
//                    path: "\(key)",
//                    expected: expectedValue.debugDescription,
//                    actual: "value is none"
//                )
//            } else if let actualValue = actualValue, let expectedValue = expectedValue, actualValue != expectedValue {
//                return MuscleAssertDifference(
//                    path: "\(key)",
//                    expected: expectedValue.debugDescription,
//                    actual: actualValue.debugDescription
//                )
//            } else {
//                return nil
//            }
//        }
//    }
//    public class func diff<T>(expected: [T], actual: [T]) -> [MuscleAssertDifference] where T: Equatable, T: CustomDebugStringConvertible {
//        let expectedLength = expected.count
//        let actualLength = actual.count
//        let length = min(expectedLength, actualLength)
//        
//        var result: [MuscleAssertDifference] = (0..<length).flatMap{index in
//            if expected[index] != actual[index] {
//                return MuscleAssertDifference(
//                    path: String(index),
//                    expected: expected[index].debugDescription,
//                    actual: actual[index].debugDescription
//                )
//            } else {
//                return nil
//            }
//        }
//        if length < expectedLength {
//            result.append(MuscleAssertDifference(
//                path: (length..<expectedLength).description,
//                expected: Array(expected[length..<expectedLength]).debugDescription,
//                actual: "too sort"
//            ))
//        } else if length < actualLength {
//            result.append(MuscleAssertDifference(
//                path: (length..<actualLength).description,
//                expected: "too sort",
//                actual: Array(actual[length..<actualLength]).debugDescription
//            ))
//        }
//        return result
//    }
//    
- (NSString *)format:(NSString *)message differences:(NSArray<MuscleAssertDifference *> *)differences {
    if ([differences count] == 0) {
        return message ?: @"";
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
