//
//  PreviewCache.h
//  BossCommonClass
//
//  Created by dp on 2021/1/18.
//

#import <Foundation/Foundation.h>
#import "PreviewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PreviewCache : NSObject

/// 实例化
+ (PreviewCache *)sharedManager;
/// 保存信息
- (void)saveWithPreviewMsg:(PreviewModel *)model;

/// 取出路径
/// @param fileName 附件名称
/// @param fileId 附件id
- (NSURL *)getPathWithFileName:(NSString *)fileName
                           fileId:(NSString *)fileId;

/// 清除所有记录
- (void)removeAllMsg;

@end

NS_ASSUME_NONNULL_END
