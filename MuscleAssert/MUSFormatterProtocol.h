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

@class MUSDifference;

@protocol MUSFormatterProtocol <NSObject>

- (NSString *)format:(NSString *)message differences:(NSArray<MUSDifference *> *)differences;

@end


#endif /* MAFormatterProtocol_h */
