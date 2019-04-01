//
//  RecommendedModel.h
//  AFNetworking
//
//  Created by admin on 2019/3/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecommendedModel : NSObject

/**
 是否是编辑状态
 */
@property(nonatomic, assign)BOOL isEditing;

/**
 是否被选中
 */
@property(nonatomic, assign)BOOL isSelected;

//@property(nonatomic, copy) NSString *testStr;


////以下为后台返回的字段
@property(nonatomic, copy)NSString *_id;
@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *phone;
@property(nonatomic, copy)NSString *code;
@property(nonatomic, copy)NSString *address;
@property(nonatomic, assign)BOOL is_complete;
@property(nonatomic, assign)NSInteger position_id;
@property(nonatomic, copy)NSString *updated_at;
@property(nonatomic, copy)NSString *submited_at;
@property(nonatomic, copy)NSString *entry_date;
////以上为后台返回的字段

@property(nonatomic, copy)NSString *positionStr;

@property(nonatomic, copy)NSString *updated_atStr;

@end

NS_ASSUME_NONNULL_END
