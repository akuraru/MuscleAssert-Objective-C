//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import "MASameTypeDiffer.h"
#import "MuscleAssertDifference.h"
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@implementation MASameTypeDiffer

- (BOOL)match:(id)left right:(id)right {
    return [left isKindOfClass:[right class]] || [right isKindOfClass:[left class]];
}

- (NSArray<MuscleAssertDifference *> *)diff:(id)left right:(id)right path:(NSString *)path delegatge:(id<MSDeepDiffProtocol>)delegate {
    if ([right isEqual:left]) {
        return @[];
    } else {
        NSArray<NSString *> *propertyNames = [self propertyNames:right];
        if (propertyNames.count == 0) {
            return @[[[MuscleAssertDifference alloc] initWithPath:path ?: @"0" left:[left debugDescription] right:[right debugDescription]]];
        } else {
            NSMutableArray *results = [NSMutableArray array];
            for (NSString *propertyName in propertyNames) {
                [results addObjectsFromArray:[delegate diff:[right performSelector:NSSelectorFromString(propertyName)] left:[left performSelector:NSSelectorFromString(propertyName)] path:propertyName]];
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
