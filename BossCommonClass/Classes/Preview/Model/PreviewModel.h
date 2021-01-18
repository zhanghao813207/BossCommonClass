#import <Foundation/Foundation.h>

#pragma mark -PreviewModel
@interface PreviewModel : NSObject <NSCoding>

/// 保存的文件名
@property (nonatomic,copy)NSString *fileName;
/// 文件id，防止上传重名文件
@property (nonatomic,copy)NSString *fileId;
/// 保存时间
@property (nonatomic,copy)NSString *saveTime;
/// 文件路径
@property (nonatomic,copy)NSURL *filePath;

@end

