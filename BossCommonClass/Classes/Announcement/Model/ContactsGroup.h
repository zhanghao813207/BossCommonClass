//
//  ContactsGroup.h
//  AFNetworking
//
//  Created by admin on 2019/4/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,SelectState) {
    SelectStateNo,//一个没选
    SelectStateAll,//全选
    SelectStateSubAll//部分选
};
@interface ContactsGroup : NSObject
@property(nonatomic, copy)NSString *_id;

/**
 头像
 */
@property(nonatomic, copy)NSString *head_img_url;


/**
 姓名
 */
@property(nonatomic, copy)NSString *name;

@property(nonatomic, copy)NSString *target_id;

/**
 自己定义
 */
@property(nonatomic, assign)SelectState state;

/**
 选择按钮是否显示
 */
@property(nonatomic, assign)BOOL isShow;
@end

NS_ASSUME_NONNULL_END
