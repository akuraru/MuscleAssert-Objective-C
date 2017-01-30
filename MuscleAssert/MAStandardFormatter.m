//
//  MAStandardFormatter.m
//  Pods
//
//  Created by akuraru on 2017/01/30.
//
//

#import "MAStandardFormatter.h"
#import "MuscleAssertDifference.h"

@implementation MAStandardFormatter

- (NSString *)format:(NSString *)message differences:(NSArray<MuscleAssertDifference *> *)differences {
    if ([differences count] == 0) {
        return nil;
    }
    NSString *text = (message != nil) ? [message stringByAppendingString:@"\n"] : @"\n";
    for (MuscleAssertDifference *diff in differences) {
        text = [text stringByAppendingFormat:@"path: .%@\n  left: %@\n  right: %@\n", diff.path, diff.left, diff.right];
    }
    return text;
}

@end
