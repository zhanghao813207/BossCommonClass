//
//  AddressBookCell.h
//  AFNetworking
//
//  Created by admin on 2019/4/17.
//

#import <UIKit/UIKit.h>
#import "ContactsGroup.h"
NS_ASSUME_NONNULL_BEGIN
@class AddressBookCell;
@protocol AddressBookCellDelegate <NSObject>

- (void)didSelectCell:(AddressBookCell *)cell model:(ContactsGroup *)model;

@end
@interface AddressBookCell : UITableViewCell
@property(nonatomic, strong)ContactsGroup *model;
@property(nonatomic, weak)id<AddressBookCellDelegate>delegate;

/**
 选择按钮是否显示
 */
@property(nonatomic, assign)BOOL isSelctHidden;
@end

NS_ASSUME_NONNULL_END
