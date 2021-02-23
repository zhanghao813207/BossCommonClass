//
//  PreviewCache.m
//  BossCommonClass
//
//  Created by dp on 2021/1/18.
//

#import "PreviewCache.h"
#import "JYCSimpleToolClass.h"
#import "JYCMethodDefine.h"

#define previewPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"BossManagerPreview.data"]

@implementation PreviewCache

/// 实例化
+ (PreviewCache *)sharedManager {
    static dispatch_once_t onceToken;
    static id instance;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

/// 保存信息
- (void)saveWithPreviewMsg:(PreviewModel *)model {
    // 如果为空，不保存
    if ([JYCSimpleToolClass stringIsEmpty:model.fileName] || [JYCSimpleToolClass stringIsEmpty:model.fileId]) {
        return;
    }
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[self getAllPreviewMsg]];
    BOOL isReplace = false;
    // 本地已有的话，替换
    for (int i = 0; i < array.count; i++) {
        PreviewModel *oldModel = array[i];
        if ([oldModel.fileId isEqualToString:model.fileId] && [oldModel.fileName isEqualToString:oldModel.fileName]) {
            [array replaceObjectAtIndex:i withObject:model];
            isReplace = true;
            break;
        }
    }
    // 添加
    if (!isReplace) {
        [array addObject:model];
    }
    [NSKeyedArchiver archiveRootObject:array toFile:previewPath];
}

/// 取出所有信息
- (NSArray *)getAllPreviewMsg {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:previewPath];
}

/// /// 取出路径
/// @param fileName 附件名称
/// @param fileId 附件id
- (NSURL *)getPathWithFileName:(NSString *)fileName
                           fileId:(NSString *)fileId {
    
    NSArray *array = [self getAllPreviewMsg];
    for (PreviewModel *model in array) {
        if ([model.fileName isEqualToString:fileName] && [model.fileId isEqualToString:fileId]) {
            NSString *localFilePath = [NSString stringWithFormat:@"%@/conract/%@",kDocumentPath, fileName];
            return [NSURL fileURLWithPath:localFilePath];
        }
    }
    
    return [NSURL URLWithString:@""];
}

/// 清除所有记录
- (void)removeAllMsg {
    [NSKeyedArchiver archiveRootObject:@[] toFile:previewPath];
}

@end
