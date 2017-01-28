//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import "MACustomDiff.h"

NS_ASSUME_NONNULL_BEGIN

@interface MAOptionalDiffer : MACustomDiff
@end

@interface MAStringDiffer : MACustomClassDiff
@end

@interface MADateDiffer : MACustomClassDiff
@end

@interface MANumberDiffer : MACustomClassDiff
@end

NS_ASSUME_NONNULL_END