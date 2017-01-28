//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import <Foundation/Foundation.h>

#define MAssert(_left,_right) XCTAssertNil([[[MuscleAssert alloc] init] deepStricEqual:_left right:_right])

NS_ASSUME_NONNULL_BEGIN

@interface MuscleAssert : NSObject

- (NSString *_Nullable)deepStricEqual:(id _Nullable)left right:(id _Nullable)right;
- (NSString *_Nullable)deepStricEqual:(id _Nullable)left right:(id _Nullable)right message:(NSString *_Nullable)message;

@end

NS_ASSUME_NONNULL_END
