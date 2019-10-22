//
//  NSString+Time.h
//  转星期
//
//  Created by admin on 2019/4/27.
//  Copyright © 2019 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Time)
- (NSString *)getTimeStr:(NSString *)timeStr;

/**
*  变更时间格式满足现实要求, 将20191010变更为2019/10/10格式
*/
+(NSString *)changeTimeDisplayFormatWithOriginalTime:(NSString *)originalTime;

@end

NS_ASSUME_NONNULL_END
