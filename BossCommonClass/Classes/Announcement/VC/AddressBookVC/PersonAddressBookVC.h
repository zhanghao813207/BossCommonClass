//
//  PersonAddressBookVC.h
//  AFNetworking
//
//  Created by admin on 2019/4/17.
//

#import <UIKit/UIKit.h>
#import "ContactsGroup.h"
#import "BossViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol PersonAddressBookVCDelegate <NSObject>

-(void)selectPerson:(NSArray *)modelArr isAll:(BOOL)select;

@end
@interface PersonAddressBookVC : BossViewController
@property(nonatomic, weak)id<PersonAddressBookVCDelegate>delegate;

/**
 是否全选
 */
@property(nonatomic, assign)BOOL isAll;
///上一个界面带回来的数据
@property(nonatomic, strong)NSArray *personSelectArr;
@property(nonatomic, strong)ContactsGroup *group;
@property(nonatomic, strong)NSString *group_id;

@property(nonatomic, assign)BOOL iscloseTalk;

@end

NS_ASSUME_NONNULL_END
