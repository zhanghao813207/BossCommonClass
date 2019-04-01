//
//  InputCell.h
//  AFNetworking
//
//  Created by admin on 2019/3/27.
//

#import <UIKit/UIKit.h>
#import "InputMessageModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol InputCellDelegate <NSObject>

- (void)inputContent:(NSString *)content type:(InputMessageModel *)type;
- (void)arrowActionWithModel:(InputMessageModel *)model;
@end

@interface InputCell : UITableViewCell
@property(nonatomic, strong)InputMessageModel *model;
@property(nonatomic,weak)id<InputCellDelegate>delegate;
@property(nonatomic,copy)NSString *detailStr;
@end

NS_ASSUME_NONNULL_END
