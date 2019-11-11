
#import <UIKit/UIKit.h>
#import "configH5.h"
#import "configMqtt.h"
#import "configH5.h"
#import "ConfigSalaryLoan.h"
@interface configModel : NSObject

@property (nonatomic, strong) configH5 * h5;
@property (nonatomic, strong) configMqtt * mqtt;
@property (nonatomic, strong) configH5 * ums;
@property (nonatomic, strong) ConfigSalaryLoan * pushu;


#pragma mark - 附加字段

/// 检查薪资贷URL是否有效
@property (nonatomic, assign) BOOL checkSalaryLoanURLValid;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
