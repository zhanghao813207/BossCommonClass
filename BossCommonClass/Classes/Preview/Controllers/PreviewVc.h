//
//  PreviewVc.h
//  BossManager
//
//  Created by 贾远潮 on 2018/8/14.
//

#import "BossViewController.h"

@interface PreviewVc : BossViewController

@property (nonatomic, strong) NSString *fileURLStr;
/// 保存文件路径
@property (nonatomic, strong) NSString *filePath;
/// 是否是BOSS之家
@property (nonatomic, assign) BOOL isBossManager;

@end
