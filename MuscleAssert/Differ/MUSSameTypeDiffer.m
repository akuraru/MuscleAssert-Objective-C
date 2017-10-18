//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import "MUSSameTypeDiffer.h"
#import "MUSDifference.h"
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@implementation MUSSameTypeDiffer

- (BOOL)match:(id)left right:(id)right {
    return [left isKindOfClass:[right class]] || [right isKindOfClass:[left class]];
}

- (NSArray<MUSDifference *> *)diff:(id)left right:(id)right path:(NSString *)path delegatge:(id<MUSDeepDiffProtocol>)delegate {
    if ([right isEqual:left]) {
        return @[];
    } else {
        NSArray<NSString *> *propertyNames = [self propertyNames:right];
        if (propertyNames.count == 0) {
            return @[[[MUSDifference alloc] initWithPath:path ?: @"0" left:[left debugDescription] right:[right debugDescription]]];
        } else {
            NSMutableArray *results = [NSMutableArray array];
            for (NSString *propertyName in propertyNames) {
                SEL selector = NSSelectorFromString(propertyName);
                if ([right respondsToSelector:selector] && [left respondsToSelector:selector]) {
                    #pragma clang diagnostic push
                    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                    id rightValue = [right performSelector:selector];
                    id leftValue = [left performSelector:selector];
                    [results addObjectsFromArray:[delegate diff:rightValue left:leftValue path:propertyName]];
                    #pragma clang diagnostic pop
                }
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

@end

NS_ASSUME_NONNULL_END
