#import <UIKit/UIKit.h>

/**
 差旅费用明细
 */
@interface BizExtraData : NSObject

/**
 补助（分）
 */
@property (nonatomic, assign) NSInteger subsidyFee;

/**
 住宿（分）
 */
@property (nonatomic, assign) NSInteger stayFee;

/**
 往返交通费
 */
@property (nonatomic, assign) NSInteger transportFee;

/**
 市内交通费
 */
@property (nonatomic, assign) NSInteger urbanTransportFee;

/**
 其他
 */
@property (nonatomic, assign) NSInteger otherFee;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
