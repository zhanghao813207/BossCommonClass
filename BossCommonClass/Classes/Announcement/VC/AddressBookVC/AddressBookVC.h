//
//  AddressBookVC.h
//  AFNetworking
//
//  Created by admin on 2019/4/17.
//

#import <UIKit/UIKit.h>
#import "ContactsGroup.h"
NS_ASSUME_NONNULL_BEGIN
@protocol AddressBookVCDelegate <NSObject>

/**
 

 @param modelArr 选中的数组
 */
- (void)select:(NSArray *)modelArr;

@end
@interface AddressBookVC : UIViewController
@property(nonatomic, weak)id<AddressBookVCDelegate>delegate;
@property(nonatomic, strong)NSArray *teamArr;
@property(nonatomic, assign)BOOL isShowSelectBar;

@end

NS_ASSUME_NONNULL_END
