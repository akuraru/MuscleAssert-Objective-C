//
//  TestModel.h
//  MuscleAssert
//
//  Created by akuraru on 2017/01/05.
//
//

#import <Foundation/Foundation.h>


@interface TestModel : NSObject
@property (nonatomic) NSString *string;
@property (nonatomic) NSNumber *number;
@property (nonatomic) NSInteger integer;

- (instancetype)initWithString:(NSString *)string;

- (instancetype)initWithString:(NSString *)string number:(NSNumber *)number interger:(NSInteger)interger;

@end
