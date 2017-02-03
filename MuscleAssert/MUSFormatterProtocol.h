//
//  MAFormatterProtocol.h
//  Pods
//
//  Created by akuraru on 2017/01/30.
//
//

#import <Foundation/Foundation.h>

#ifndef MAFormatterProtocol_h
#define MAFormatterProtocol_h

NS_ASSUME_NONNULL_BEGIN

@class MUSDifference;

@protocol MUSFormatterProtocol <NSObject>

- (NSString *)format:(NSString *)message differences:(NSArray<MUSDifference *> *)differences;

@end

NS_ASSUME_NONNULL_END

#endif /* MAFormatterProtocol_h */
