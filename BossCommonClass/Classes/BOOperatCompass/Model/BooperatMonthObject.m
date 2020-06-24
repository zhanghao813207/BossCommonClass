//
//  BooperatMonthObject.m
//  BossCommonClass
//
//  Created by 高炀辉 on 2020/6/15.
//

#import "BooperatMonthObject.h"

@implementation BooperatMonthObject


- (instancetype)init:(BOOL)isSelect month:(NSString *)month:(int)month_int
{
    self = [super init];
    if (self) {
        self.isselect = isSelect;
        self.name = month;
        self.month_int = month_int;
    }
    return self;
}
-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[@"selectStatus"] isKindOfClass:[NSNull class]]){
        self.isselect = [dictionary[@"selectStatus"] boolValue];
    }
    if(![dictionary[@"month"] isKindOfClass:[NSNull class]]){
        self.name = dictionary[@"month"];
    }
    if(![dictionary[@"month_int"] isKindOfClass:[NSNull class]]){
        self.month_int = [dictionary[@"month_int"] intValue];
    }
    return self;
}
@end
