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
    return [self initWithString:string number:@0 interger:0];
}

- (instancetype)initWithString:(NSString *)string number:(NSNumber *)number interger:(NSInteger)interger {
    self = [super init];
    if (self) {
        _string = string;
        _number = number;
        _integer = interger;
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    return [self.string isEqualToString:[object string]]
    && [self.number isEqualToNumber:[object number]]
    && self.integer == self.integer;
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"TestModel(string: %@, number: %@, integer: %zd)", self.string, self.number, self.integer];
}

@end
