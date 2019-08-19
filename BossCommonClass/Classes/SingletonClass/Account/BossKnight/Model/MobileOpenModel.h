#import <UIKit/UIKit.h>

/**
 模块配置文件
 */
@interface MobileOpenModel : NSObject

/**
 个户注册 - 伯渡
 */
@property (nonatomic, assign) BOOL boduRegister;

/**
 消息模块
 */
@property (nonatomic, assign) BOOL message;

/**
 服务费预支
 */
@property (nonatomic, assign) BOOL salaryLoan;

/**
 在线学习模块 - 云学堂
 */
@property (nonatomic, assign) BOOL schoolStudy;

/**
 钱包模块
 */
@property (nonatomic, assign) BOOL wallet;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
