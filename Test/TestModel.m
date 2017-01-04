//
//  TestModel.m
//  MuscleAssert
//
//  Created by akuraru on 2017/01/05.
//
//

#import "TestModel.h"

@implementation TestModel

- (instancetype)initWithString:(NSString *)string {
    self = [super init];
    if (self) {
        _string = string;
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    return [self.string isEqualToString:[object string]];
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"TestModel(string: %@)", self.string];
}

@end
