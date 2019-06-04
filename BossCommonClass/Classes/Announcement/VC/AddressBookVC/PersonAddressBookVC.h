//
//  PersonAddressBookVC.h
//  AFNetworking
//
//  Created by admin on 2019/4/17.
//

#import <UIKit/UIKit.h>
#import "ContactsGroup.h"

NS_ASSUME_NONNULL_BEGIN
@protocol PersonAddressBookVCDelegate <NSObject>

-(void)selectPerson:(NSArray *)modelArr isAll:(BOOL)select;

@end
@interface PersonAddressBookVC : UIViewController
@property(nonatomic, weak)id<PersonAddressBookVCDelegate>delegate;

/**
 是否全选
 */
@property(nonatomic, assign)BOOL isAll;
///上一个界面带回来的数据
@property(nonatomic, strong)NSArray *personSelectArr;
@property(nonatomic, strong)ContactsGroup *group;
@end

NS_ASSUME_NONNULL_END
