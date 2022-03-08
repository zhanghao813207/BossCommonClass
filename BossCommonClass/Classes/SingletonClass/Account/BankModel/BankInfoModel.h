#import <UIKit/UIKit.h>

@interface BankInfoModel : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * bankBranch;
@property (nonatomic, strong) NSString * bankBranchName;
@property (nonatomic, strong) NSArray * bankLocation;
@property (nonatomic, strong) NSString * cardHolderBankCardNo;
@property (nonatomic, strong) NSString * cardHolderName;
@property (nonatomic, strong) NSString * collectIdCardNo;
@property (nonatomic, strong) NSString * collectPhone;
@property (nonatomic, strong) NSString * collectSex;
@property (nonatomic, assign) NSInteger paymentType;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end