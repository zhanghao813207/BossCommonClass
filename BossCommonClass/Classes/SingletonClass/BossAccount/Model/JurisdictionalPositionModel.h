//
//  JurisdictionalPositionModel.h
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/7/16.
//

#import <Foundation/Foundation.h>

@interface JurisdictionalPositionModel : NSObject

@property (nonatomic, assign) BOOL operable;

@property (nonatomic, assign) NSUInteger pid;

@property (nonatomic, strong) NSString *position_id;

@property (nonatomic, strong) NSString *position_name;

- (NSDictionary *)decodeToDic;

@end
