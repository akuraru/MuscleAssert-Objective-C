//
//  MuscleAssert.swift
//  MuscleAssert
//
//  Created by akuraru on 2016/12/17.
//
//

#import "MUSCustomDiffer.h"
#import "MUSFormatterProtocol.h"

#define MAssert(_left,_right) XCTAssertNil([[[MuscleAssert alloc] init] deepStricEqual:_left right:_right])

NS_ASSUME_NONNULL_BEGIN

@class MUSCustomDiffer;

@interface MuscleAssert : NSObject <MUSDeepDiffProtocol>

@property (nonatomic, nonnull) id<MUSFormatterProtocol> formatter;

- (NSString *_Nullable)deepStricEqual:(id _Nullable)left right:(id _Nullable)right;
- (NSString *_Nullable)deepStricEqual:(id _Nullable)left right:(id _Nullable)right message:(NSString *_Nullable)message;

- (void)cons:(MUSCustomDiffer *)differ;
- (void)add:(MUSCustomDiffer *)differ;

@end

NS_ASSUME_NONNULL_END
