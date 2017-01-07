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
    return [self initWithString:string number:@0];
}

- (instancetype)initWithString:(NSString *)string number:(NSNumber *)number {
    self = [super init];
    if (self) {
        _string = string;
        _number = number;
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    return [self.string isEqualToString:[object string]] && [self.number isEqualToNumber:[object number]];
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"TestModel(string: %@, number: %@)", self.string, self.number];
}

@end
