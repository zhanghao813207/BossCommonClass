//
//  BooperatMonthObject.h
//  BossCommonClass
//
//  Created by 高炀辉 on 2020/6/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BooperatMonthObject : NSObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) BOOL isselect;
@property (nonatomic, assign) int month_int;


-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
