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

- (NSArray<MUSDifference *> *)diff:(id)left right:(id)right path:(nullable NSString *)path delegatge:(id<MUSDeepDiffProtocol>)delegate {
    if ([right isEqual:left]) {
        return @[];
    } else {
        unsigned int count;
        objc_property_t* props = class_copyPropertyList([right class], &count);
        if (count == 0) {
            return @[[[MUSDifference alloc] initWithPath:path ?: @"0" left:[left debugDescription] right:[right debugDescription]]];
        } else {
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            NSMutableArray *results = [NSMutableArray arrayWithCapacity:count];
            for (int i = 0; i < count; i++) {
                objc_property_t property = props[i];
                const char * name = property_getName(property);
                NSString *propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
                const char * type = property_getAttributes(property);
                
                NSString * typeString = [NSString stringWithUTF8String:type];
                NSArray * attributes = [typeString componentsSeparatedByString:@","];
                NSString * typeAttribute = [attributes objectAtIndex:0];
                NSString * propertyType = [typeAttribute substringFromIndex:1];
                
                SEL selector = NSSelectorFromString(propertyName);
                NSLog(@"%@", typeString);
                if ([propertyType hasPrefix:@"@"]) {
                    id rightObject = [right performSelector:selector];
                    id leftObject = [left performSelector:selector];
                    [results addObjectsFromArray:[delegate diff:rightObject left:leftObject path:[self pathByAppendingPath:path string:propertyName]]];
                } else if ([propertyType isEqualToString:@"q"]) {
                    long leftInt = (long)[left performSelector:selector];
                    long rightInt = (long)[right performSelector:selector];
                    if (leftInt != rightInt) {
                        [results addObject:[[MUSDifference alloc] initWithPath:[self pathByAppendingPath:path string:propertyName] left:[@(leftInt) debugDescription] right:[@(rightInt) debugDescription]]];
                    }
                }
            }
            #pragma clang diagnostic pop
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
