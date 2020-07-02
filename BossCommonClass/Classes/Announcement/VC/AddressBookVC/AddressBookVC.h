//
//  AddressBookVC.h
//  AFNetworking
//
//  Created by admin on 2019/4/17.
//

#import <UIKit/UIKit.h>
#import "ContactsGroup.h"
#import "BossViewController.h"
NS_ASSUME_NONNULL_BEGIN
@protocol AddressBookVCDelegate <NSObject>

/**
 

 @param modelArr 选中的数组
 */
- (void)selectModelDelegate:(NSArray *)modelArr;

@end
@interface AddressBookVC : BossViewController
@property(nonatomic, weak)id<AddressBookVCDelegate>delegate;
@property(nonatomic, strong)NSArray *teamArr;
@property(nonatomic, assign)BOOL isShowSelectBar;
@property(nonatomic, assign)BOOL iscloseTalk;
@property (nonatomic, strong) NSString *wppId;

@end

NS_ASSUME_NONNULL_END
