//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import "MACustomDiff.h"
#import "MuscleAssertDifference.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MACustomDiff

- (instancetype)initWithMatch:(BOOL(^)(id, id))match diff:(NSArray<MuscleAssertDifference *> *(^)(id, id))diff {
    self = [super init];
    if (self) {
        self.match = match;
        self.diff = diff;
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
