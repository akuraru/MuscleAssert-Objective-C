//
//  MAStandardFormatter.m
//  Pods
//
//  Created by akuraru on 2017/01/30.
//
//

#import "MUSStandardFormatter.h"
#import "MUSDifference.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MUSStandardFormatter

- (NSString * _Nullable)format:(NSString *)message differences:(NSArray<MUSDifference *> *)differences {
    if ([differences count] == 0) {
        return nil;
    }
    NSString *text = (message != nil) ? [message stringByAppendingString:@"\n"] : @"\n";
    for (MUSDifference *diff in differences) {
        text = [text stringByAppendingFormat:@"path: .%@\n  left: %@\n  right: %@\n", diff.path, diff.left, diff.right];
    }
    return text;
}

@end

NS_ASSUME_NONNULL_END
